from flask import Flask
app = Flask(__name__)

@app.route('/multiplicar/<numero1>/por/<numero2>')
def multiplicar (numero1, numero2):
    result = int(numero1) * int(numero2)
    return str(result)
