from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def form():
    if not os.path.isfile('output.txt'):
        file = open('output.txt', 'a')
    file = open('output.txt', 'r')
    x = file.readlines()
    file.close()
    return render_template('form.html')

@app.route('/hello', methods=['GET', 'POST'])
def hello():
    file = open('output.txt', 'a')
    file.write(f"{request.form['say']} {request.form['to']}\n")
    file.close()
    return render_template('greeting.html', say=request.form['say'], to=request.form['to'])

if __name__ == "__main__":
    app.run()
