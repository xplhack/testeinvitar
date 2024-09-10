#!/bin/bash

# Variables
DOMAIN="gatesccnmandarinlatamsrc.com"  # Cambia esto por tu dominio
EMAIL="gatesccn+1@gmail.com"  # Cambia esto por tu correo electrónico

# Instalación de Nginx
sudo apt update
sudo apt install nginx -y

# Crear un archivo de configuración para el dominio
sudo tee /etc/nginx/sites-available/$DOMAIN > /dev/null <<EOL
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root /var/www/$DOMAIN;
    index index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL

# Crear directorio para el dominio
sudo mkdir -p /var/www/$DOMAIN
echo "<html><head><title>$DOMAIN</title></head><body><h1>¡Bienvenido a $DOMAIN!</h1></body></html>" | sudo tee /var/www/$DOMAIN/index.html

# Activar el archivo de configuración
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/

# Verificar la configuración de Nginx
sudo nginx -t

# Reiniciar Nginx
sudo systemctl restart nginx

echo "El dominio $DOMAIN ha sido configurado en el VPS."
