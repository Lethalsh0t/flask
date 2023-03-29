from flask import Flask, render_template, request
import pyodbc

app = Flask(__name__)

# Set up database connection
cnxn = pyodbc.connect('Driver={SQLite};Database=C:/Users/opet2/testflaskapp/chinook.db')
cursor = cnxn.cursor()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        CustomerId = request.form['CustomerId']
        query = f"SELECT FirstName, LastName FROM customers WHERE CustomerId = '{CustomerId}'"
        cursor.execute(query)
        results = cursor.fetchall()
        return render_template('results.html', results=results)
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)