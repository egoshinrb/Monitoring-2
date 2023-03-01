# LinuxMonitoring v2.0

## Part 9. Дополнительно. Свой node_exporter

- Сначала установим nginx и в файле `/etc/nginx/nginx.conf` добавим описание сервера (порт, локацию html файла и служебную инвормацию).
![grafana](images/01.jpg)
![grafana](images/02.jpg)
---
![grafana](images/03.jpg)

- Затем `sudo systemctl restart nginx.service`

- В конфиг файл прометеуса добавим новый джоб:
![grafana](images/04.jpg)

- Теперь напишем скрипт, который будет формировать html страницу по формату `node-exporter`, которую будет забирать прометеус от энджинкса. На этой странице нужно предусмотреть уникальные имена метрик, по которым мы будем их искать в прометеусе.
![grafana](images/05.jpg)

- Такой формат html файла должен получиться.
![grafana](images/06.jpg)

- На странице прометеуса можно выбрать наши метрики.
![grafana](images/07.jpg)
![grafana](images/08.jpg)

- В графане создаем дашборд, где выводим панели с нашими метриками.
![grafana](images/09.jpg)

- Так можно создать любой кастомный экспортер.