# LinuxMonitoring v2.0

## Part 6. GoAccess

- Установим goaccess, через sudo apt. Запустим с флагом '-f' и укажем наши файлы логов.
![goaccess](images//02.png)

- В выпадающем списке выберем первый пункт меню.
![goaccess](images/03.png)

- Открываются метрики, которые мы можем анализировать
![goaccess](images/04.png)
> показывает количество уникальных ip
![goaccess](images/05.png)
> следующий экран с метриками
![goaccess](images/06.png)
> здесь статистика по кодам ответов

- Здесь заметим, что ругается на то, что в конфиг файле не может найти формат времени.
![goaccess](images/08.png)
> так можно использовать конвейер через awk и вывести в goaccess только ошибочные запросы

- Настроим конфиг файл -> раскомментим необходимые строки:
![goaccess](images/09.png)
![goaccess](images/10.png)
![goaccess](images/11.png)

- Еще раз попробуем запустить goaccess, добавив флаг -p с указанием конфиг файла. Минус в самом конце означает ввод данных со стандартного дескриптора ввода STDINPUT.
![goaccess](images/12.png)

- Теперь видим только ошибочные запросы....
![goaccess](images/13.png)

- И количество уникальных ip с ошибочными запросами.
![goaccess](images/14.png)

- Установим nginx и добавим в конфигфайле описание сервера (порт, откуда брать html и служебную информацию). Можно будет открывать отчет с локального компьютера через проброс портов.
![goaccess](images/16.png)
![goaccess](images/17.png)

- Теперь запустим goaccess с флагом -o и укажем название веб-страницы с отчетом.
![goaccess](images/15.png)

- Теперь можно открыть страницу и увидеть красивые графики.
![goaccess](images/18.png)

- Хороший гайд
https://kali.tools/?p=4357