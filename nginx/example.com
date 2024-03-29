# /etc/nginx/sites-available/example.com
# ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com

server {
    if ($host = example.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    listen [::]:80;

    server_name example.com www.example.com;
    return 404; # managed by Certbot
}

server {
    # Listen HTTP
    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/lglrcx.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/lglrcx.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

    server_name example.com www.example.com;
    access_log /var/log/nginx/example.com/access.log;
    error_log /var/log/nginx/example.com/error.log;

    root /var/www/example.com/html;

    location / {
        try_files $uri $uri/ /index.html?$args;
    }

    location /assets/ {
    }

    location ~ \.(txt|ico|js|css) {
    }

    # Proxy Config
    location /api/ {
        proxy_pass http://127.0.0.1:8081;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_pass_request_headers on;
    }
    location ~ /.well-known {
       allow all;
    }
}
