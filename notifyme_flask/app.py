from flask import Flask, render_template, request, redirect
import json
import os

app = Flask(__name__)

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

    search_query = request.args.get('search', '').lower()
    category_filter = request.args.get('category_filter', '')
    status_filter = request.args.get('status_filter', '')

    # 1. Arama filtresi
    if search_query:
        tasks = [t for t in tasks if search_query in t['title'].lower() or search_query in t['description'].lower()]

    # 2. Kategori filtresi
    if category_filter:
        tasks = [t for t in tasks if t.get('category') == category_filter]

    # 3. Durum filtresi



    def parse_date(task):
        try:
            return datetime.strptime(task['due_date'], "%Y-%m-%d")
        except ValueError:
            return datetime.max

    tasks.sort(key=parse_date)
    

    return render_template("index.html", tasks=tasks)




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

@app.route("/complete/<int:index>")
def complete(index):
    tasks = load_tasks()
    if 0 <= index < len(tasks):
        tasks[index]["completed"] = True
        save_tasks(tasks)
    return redirect("/")

@app.route("/delete/<int:index>")
def delete(index):
    tasks = load_tasks()
    if 0 <= index < len(tasks):
        tasks.pop(index)
        save_tasks(tasks)
    return redirect("/")

if __name__ == "__main__":
    app.run(debug=True)
