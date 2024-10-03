from flask import Flask
from flask import request
from flask import render_template

# Crear la instancia de Flask
sample = Flask(__name__)

# Definir la ruta principal
@sample.route("/")
def main():
    return render_template("index.html")

# No es necesario el bloque para ejecutar Flask directamente
# ya que Gunicorn se encargará de ejecutar la aplicación.
if __name__ == "__main__":
    pass  # No se necesita ejecutar Flask directamente aquí
