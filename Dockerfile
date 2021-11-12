FROM alpine:latest
LABEL maintainer="mailsvb@gmail.com"

RUN apk update && apk upgrade && apk add --no-cache nodejs npm supervisor git coturn

WORKDIR /opt
RUN git clone --depth 1 --branch v1.2.8 https://github.com/genieacs/genieacs.git
WORKDIR /opt/genieacs
RUN npm install && npm run build

RUN addgroup -S genieacs && adduser -S -H genieacs -G genieacs

RUN mkdir /opt/genieacs/ext && \
    chown genieacs:genieacs /opt/genieacs/ext

RUN mkdir -p /opt/genieacs/certs && \
    echo "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURBRENDQWVpZ0F3SUJBZ0lJSk9ub1F6dDdudzR3RFFZSktvWklodmNOQVFFTEJRQXdJREVMTUFrR0ExVUUKQmhNQ1JFVXhFVEFQQmdOVkJBTVRDR2RsYm1sbFlXTnpNQ0FYRFRJeE1URXdNVEF3TURBd01Gb1lEems1T1RreApNak14TWpNMU9UVTVXakFnTVFzd0NRWURWUVFHRXdKRVJURVJNQThHQTFVRUF4TUlaMlZ1YVdWaFkzTXdnZ0VpCk1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRRFQ1T1ViWXNtaGlYcy82WGVKbW5HcURZZHcKTlQ3VUl4V2JYZDkycURWd3h5eHMzeW1pU1RIdnpkTWdGYnFNL0JvSlowb0J1WUc4Qno5cjVtTWZOaEhwdGRzTApnZjVhWnNTVG92a01RMVVaSWhPaERIMk92cjhRZDFkejl6N1J1V3k1ck1ZWGEyczhVc1NFeVRhZmlKQmZUYmhMCjhoYnNDTjhUeUZkSEpyWmNvSE1PdmtGa1hWQ3d0RFY3Zy9BbHdRTERvZ215WWxWTzN5dExhNVJtTVNrSEI3TlkKdDlaWDVHeHh0TXBEcHZ1YlhUU1c3YjdmYnptMGRrcm1TRHFyY0srREZOd1FRTWU1cXJhQThOb3YvRzdxc1hMVApUaEVKWDR4d3RVMGVteEZwQmJmdkVlenVxMjEzSDZsMnZXeTNZVzBFYmtjZjZlejVkc3haNXp2WGFLVTVBZ01CCkFBR2pQREE2TUF3R0ExVWRFd0VCL3dRQ01BQXdIUVlEVlIwT0JCWUVGQWFRVW1YMy8vWVdtNmx1WUg3ZU9USGcKaTJ6RU1Bc0dBMVVkRHdRRUF3SUY0REFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBRjNSY2JrY2tuT2wzcmpwSgpXclBBNSt6RkpTZGVBYWE5UTVkaE1LcDNxRC8zSjdyczAxeVBvUDRyaHpxN0VuUGxsN24wN3cyOFJXV2VqT3lKClVxeXlydFlWOHh2QnVGR1pIZmVLR05YRVV6TEtVRUVUTDdITTVSdTFYM2hPYStHczIvOWx4bHdqZGZkSk9Dcm4KY1F4WGF4TlFOajM5dVJ4dmJST3ROanZRbGs0aDJFYU1GV2hrVVE0UE1JUTlSZmtOVHZRek9jdEVzUXdFUERvRwpOZDBKQ25oQ0o5YU43VmJIQWhpYTFTc0RNSlR6bmIvVGVLdGdXNUcrb1ZBb3JUYWNhcHQrTjNGS3FWdkowNkFoCml0UFVvSmZhZ1N1UHlxS3dRdEQyMysyb3hiSDIxQnBhdjhTc2x0OWFGTlB6MXJFb08ydCtndnF2Q3h2em5PWEgKSzhlRlN3PT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=" | base64 -d > /opt/genieacs/certs/server.crt && \
    echo "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb2dJQkFBS0NBUUVBMCtUbEcyTEpvWWw3UCtsM2lacHhxZzJIY0RVKzFDTVZtMTNmZHFnMWNNY3NiTjhwCm9ra3g3ODNUSUJXNmpQd2FDV2RLQWJtQnZBYy9hK1pqSHpZUjZiWGJDNEgrV21iRWs2TDVERU5WR1NJVG9ReDkKanI2L0VIZFhjL2MrMGJsc3VhekdGMnRyUEZMRWhNazJuNGlRWDAyNFMvSVc3QWpmRThoWFJ5YTJYS0J6RHI1QgpaRjFRc0xRMWU0UHdKY0VDdzZJSnNtSlZUdDhyUzJ1VVpqRXBCd2V6V0xmV1YrUnNjYlRLUTZiN20xMDBsdTIrCjMyODV0SFpLNWtnNnEzQ3ZneFRjRUVESHVhcTJnUERhTC94dTZyRnkwMDRSQ1YrTWNMVk5IcHNSYVFXMzd4SHMKN3F0dGR4K3BkcjFzdDJGdEJHNUhIK25zK1hiTVdlYzcxMmlsT1FJREFRQUJBb0lCQUdFeGMvbWMxWm5ZQXdXcwo1RnprejlCTnhsc3N3VFh6SmQwUE1Rb3ZXOXZ3TUN0OExZKzMvVVRlNTBHblZkdUhZN1grZjg3TXRYcDI1SnRzCm9QalhCMTVwUVNGRkxsTnZJaW9LTGl4MjBoam1MWlRJc3VzQUNZblhBL0U0YnNNcVIzbmZpem1BMXo1alJLc1gKMUl0V3k4bzdUeGJlNDY2KzN2d25BQW10OHlZR3lUU0t0L3VFVzd1UFlYbmt5SlorclpNVWc0Ukt1NkdSODhDVgpQazV5S0NpMWMvenNWUFdrcU5vcFBYYTVKM0JqTzBtYkpvYmVFc3pET0dVNm9lNUNLdSsvNTRsTmg5WnVkQ25wCnk5UUFIdTBtaGJmVWhPbFZlUW5STXEyeWVNZkVCZ2NCQkU4ZVNsaVpaNmVKVWZUQ25sUjJOZitwSjVTSGZ0SC8KbXpmcTJWVUNnWUVBNm5iNFB1R2dqdVozN25qek9iUjlTbkpSR1prbnRnMU9QdDQrb3JkbW1qeVh4R0YrU3ppNgpzZTdpY3p6ZXF4KzV0cWRzeVlWL0RqTEhGQlNNV0RWQXJ5VXhiOStyTlBjTXZ2WUpGNUlPWkJoOGR0NFRBaGhWCm1qUnJ5VEVTajEySWJZL093WEtrMXFMWFB5cjA2OFBsTlYwditvM0wrcGk3T1BRelRaei9YeE1DZ1lFQTUxczMKZXpUSmplL0lGOUlId1FSWHA4Z1dtMG9JTzhUNHlEcVUrZ2YzajAySlB1S2x1VEdQazI2N1NDSGQzZmFsbE1TMAovNmZTRDJXSHdoSEIwYVM2Q1RDbkUxL2RXRmMxNTVqMUEyckI3Zzlxa1cvRUFiTk5qMnZ6QmI4Mm5TaHBWdGtNCnNMTUs2VTdMNGlKSTdmajB4UFY1cy9LaTN3cHA2YWJkSVJUVVdBTUNnWUFaeGVJYjUybGl5K3E3Q0FpVWUwYWEKZkY1MTFlUUxtd0xTM2xNOFI3UzdsNVdIUE1CSlBIOHBOLzBrZGJoMFR4UjNBNGh0em9MYzZMQUJnUkM4VVg0Kwp3blBndkZGeGpRYVZweTN3clZsdm4xRnZMNUlmVk5WMEVmY1hNcEc3dUtoYWdzaFRjMnF6UFVzejRtRHgyYUxFCmJ1M3JPTk1IUk9xdnBBaFBxOFpXaVFLQmdFYXJtMmY4T1BFdFpJNjZMbm9zVEdaSS9YYlVCMjNTZmpnVGhQeFgKUUt5NmY0a0JES1JrV2pvcjRmTm52UEVYYlg3akUzTGduWTdzY2FxN1o5d1ZHR3JFUE5UelBKYkdsUVc0dUdjaAp6amxjNWkyazJWZTNvS0tGMUFkV1lHVmpPY0k0ck9LdzNrMWtMMjFWRWJmM2l6VTYwc0ZBQmJaaDVQWmxiVGkwCnR5Um5Bb0dBZVkreE90OUdJTTNxdEJJSkxPdVZGTjRqamswN05wVU5OT3IwQzdwMFFGR2EwaDlWQ0RzLy9kaksKN0VRc21adWVCQW9pcnFKK0dkTVJYNjZqSFp1QWJqNyt4MkxvZ0RSeWpmYUdxSVBNR3dkQlowWFo0eXlCSUdUTQo3ZVV5K2d2ZmpFb2lIMWdNbmFZV0JWeHR6Z0V1ZEpTYWhUSUt0Tmw0T1gxWEJPR3gyYjA9Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==" | base64 -d > /opt/genieacs/certs/server.pem

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
