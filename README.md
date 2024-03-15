﻿# mamuro_tf
Este es un proyecto de Terraform que sirve para desplegar la aplicacion mamuro. Para ello levanta una instancia EC2, crea un grupo de seguridad y configura los puertos a usar, generar el tls private key y el archivo .pem para conectarse a la instancia, hace las configuraciones necesarias mediante el archivo user-data.sh y listo.

# Instalaciones necesarias

<ul>
  <li><a href="https://github.com/Moisesmp75/mamuro_tf.git">Terraform</a></li>
  <li>Una cuenta de AWS con el secret key y access key</li>
</ul>

# Levantar instancia

Ejecutar
<pre>
  terraform init
</pre>
Esperar a que termine y luego
<pre>
  terraform apply
</pre>
y a continuacion le pedirá que ingrese su aws_access_key y luego aws_secret_key. Una vez ingresado ambas key, esperar un momento e ingresar a la cuenta de aws para ver el estado de la instancia. Los puertos disponibles son el 4080 (zincsearch) y el 3000 (mamuro-app)
