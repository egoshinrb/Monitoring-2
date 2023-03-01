#!/bin/bash

for i in {1..5}; do
    file="file_$i.log"
    reg_count=$(( $RANDOM%901 + 100 ))

    add_time_sec=(24*60*60 - 1)/$reg_count
    time_sec=0
    date="$(( $RANDOM%30 + 1 ))/$(date +%b/%Y)"

    array_request=(GET POST PUT PATCH DELETE)
    array_request_addr=('/index.1017b8a8.js' '/vendor.8e8f04a7.js' '/index.d719a500.css' '/static.js'
    '/favicon.ico' '/index.86594517.js' '/SBSansDisplay-Bold.1cb51071.otf' '/SBSansDisplay-SemiBold.5957ec3d.otf'
    '/SBSansDisplay-Regular.5dddcdc3.otf' '/SBSansText-Bold.08273f8b.otf' '/SBSansText-SemiBold.b9aafb70.otf' '/SBSansText-Regular.58ce8a79.otf'
    '/services/graphql' '/index.baafd6ed.js' '/index.5216c341.js' '/useUnsubcribeFromEvent.1a2d7a61.js'
    '/jazz.123601d6.js' '/range.5ae44316.js' '/_isIterateeCall.0055ed8e.js' '/index.bb1a5772.js')

    array_reply=(200 201 400 401 403 404 500 501 502 503)
    array_URL=(http://178.23.151.201/ -)
    array_agent=(Mozilla Google Chrome Opera Safari 'Internet Explorer' "Microsoft Edge" 'Crawler and bot' "Library and net tool")

    for (( j = 0; j < $reg_count; ++j )); do
        ip="$(($RANDOM%256)).$(($RANDOM%256)).$(($RANDOM%256)).$(($RANDOM%256))"
        
        time_sec=$(( time_sec + add_time_sec ))
        time_all=$(echo $time_sec | awk '{printf "%02d:%02d:%02d", $1/3600, $1/60%60, $1%60}')
        time_zone=$(date | awk '{print $7 "00"}')

        request=${array_request[$RANDOM%5]}
        request_addr=${array_request_addr[$RANDOM%20]}

        reply=${array_reply[$RANDOM%10]}
        size=$(( $RANDOM%1000 + 1 ))

        URL=${array_URL[$RANDOM%2]}
        agent=${array_agent[$RANDOM%9]}

        # echo "$file | $reg_count | $ip | $date | $time_sec |$time_all | $request | $reply |"
        echo "$ip - - [$date:$time_all $time_zone] \"$request $request_addr HTTP/1.1\" $reply $size \"$URL\" \"$agent\"" >> $file
    done
        
done

# reply
# 200 OK — успешный запрос. Если клиентом были запрошены какие-либо данные, то они находятся в заголовке и/или теле сообщения.
# 201 Created — в результате успешного выполнения запроса был создан новый ресурс.
# 400 Bad Request — сервер обнаружил в запросе клиента синтаксическую ошибку.
# 401 Unauthorized — для доступа к запрашиваемому ресурсу требуется аутентификация.
# 403 Forbidden — сервер понял запрос, но он отказывается его выполнять из-за ограничений в доступе для клиента к указанному ресурсу.
# 404 Not Found — сервер понял запрос, но не нашёл соответствующего ресурса по указанному URL. Самая распространённая ошибка при пользовании Интернетом, основная причина — ошибка в написании адреса Web-страницы. 
# 500 Internal Server Error — любая внутренняя ошибка сервера, которая не входит в рамки остальных ошибок класса.
# 501 Not Implemented — сервер не поддерживает возможностей, необходимых для обработки запроса. Типичный ответ для случаев, когда сервер не понимает указанный в запросе метод.
# 502 Bad Gateway — сервер, выступая в роли шлюза или прокси-сервера, получил недействительное ответное сообщение от вышестоящего сервера.
# 503 Service Unavailable — сервер временно не имеет возможности обрабатывать запросы по техническим причинам (обслуживание, перегрузка и прочее).