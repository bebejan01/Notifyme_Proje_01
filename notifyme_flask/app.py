from flask import Flask, render_template, request, redirect, url_for, flash
import json
import os
import math

app = Flask(__name__)
app.secret_key = "notifyme_secret"  


TASK_FILE = "tasks.json"

from datetime import datetime  # Üstte import edilmeli

def load_tasks():
    if not os.path.exists(TASK_FILE):
        return []

    with open(TASK_FILE, "r") as f:
        tasks = json.load(f)

    # Görevleri tarihe göre sırala
    tasks.sort(key=lambda x: datetime.strptime(x["due_date"], "%Y-%m-%d"))
    return tasks


def save_tasks(tasks):
    with open(TASK_FILE, "w") as f:
        json.dump(tasks, f, indent=4)

@app.route("/")
def index():
    tasks = load_tasks()

    search_query    = request.args.get('search', '').lower()
    category_filter = request.args.get('category_filter', '')
    status_filter   = request.args.get('status_filter', '')
    hide_completed  = request.args.get('hide_completed', 'false').lower() == 'true'

    # 1) Arama
    if search_query:
        tasks = [t for t in tasks
                 if search_query in t['title'].lower()
                 or search_query in t['description'].lower()]

    # 2) Kategori
    if category_filter:
        tasks = [t for t in tasks if t.get('category') == category_filter]

    # 3) Durum
    if status_filter == "completed":
        tasks = [t for t in tasks if t.get("completed") == True]
    elif status_filter == "pending":
        tasks = [t for t in tasks if t.get("completed") == False]

    # 4) Tamamlanmışları gizle
    if hide_completed:
        tasks = [t for t in tasks if not t.get("completed")]

    # Sıralama (tarih)
    def parse_date(task):
        try:
            return datetime.strptime(task['due_date'], "%Y-%m-%d")
        except ValueError:
            return datetime.max
    tasks.sort(key=parse_date)

    # --- PAGINATION ---
    per_page = 12
    try:
        page = int(request.args.get('page', 1))
    except ValueError:
        page = 1

    total = len(tasks)
    total_pages = max(1, math.ceil(total / per_page))
    page = max(1, min(page, total_pages))  # clamp

    start = (page - 1) * per_page
    end   = start + per_page
    page_tasks = tasks[start:end]

    return render_template(
        "index.html",
        tasks=page_tasks,
        hide_completed=hide_completed,
        page=page,
        per_page=per_page,
        total=total,
        total_pages=total_pages,
        start_index=start,
        end_index=min(end, total)
    )

    
    hide_completed = request.args.get('hide_completed', 'false').lower() == 'true'
    return render_template("index.html", tasks=tasks, hide_completed=hide_completed)





@app.route("/add", methods=["POST"])
def add():
    title = request.form["title"]
    description = request.form["description"]
    due_date = request.form["due_date"]
    category = request.form["category"]

    task = {
        "title": title,
        "description": description,
        "due_date": due_date,
        "category": category,  
        "completed": False
    }

    tasks = load_tasks()
    tasks.append(task)
    save_tasks(tasks)
    return redirect("/")

@app.route('/edit/<int:index>', methods=['GET', 'POST'])
def edit_task(index):
    tasks = load_tasks()
    task = tasks[index]

    if request.method == 'POST':
        task['title'] = request.form['title']
        task['description'] = request.form['description']
        task['category'] = request.form['category']
        task['due_date'] = request.form['due_date']
        task['completed'] = 'completed' in request.form
        save_tasks(tasks)

        return redirect(url_for('index',
                                search=request.args.get('search',''),
                                category_filter=request.args.get('category_filter',''),
                                status_filter=request.args.get('status_filter',''),
                                hide_completed=request.args.get('hide_completed','false'),
                                page=request.args.get('page', 1)))

    return render_template('edit.html', task=task)




@app.route("/complete/<int:index>")
def complete(index):
    tasks = load_tasks()
    if 0 <= index < len(tasks):
        tasks[index]["completed"] = True
        save_tasks(tasks)
        flash("Görev başarıyla tamamlandı! ✅")
    return redirect(url_for('index',
                            search=request.args.get('search',''),
                            category_filter=request.args.get('category_filter',''),
                            status_filter=request.args.get('status_filter',''),
                            hide_completed=request.args.get('hide_completed','false'),
                            page=request.args.get('page', 1)))



@app.route("/delete/<int:index>")
def delete(index):
    tasks = load_tasks()
    if 0 <= index < len(tasks):
        tasks.pop(index)
        save_tasks(tasks)
        flash("Görev silindi 🗑️")
    return redirect(url_for('index',
                            search=request.args.get('search',''),
                            category_filter=request.args.get('category_filter',''),
                            status_filter=request.args.get('status_filter',''),
                            hide_completed=request.args.get('hide_completed','false'),
                            page=request.args.get('page', 1)))



if __name__ == "__main__":
    app.run(debug=True)
