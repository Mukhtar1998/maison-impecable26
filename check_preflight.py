import http.client
conn = http.client.HTTPConnection('127.0.0.1',8000,timeout=5)
conn.request('OPTIONS','/api/review',headers={'Origin':'http://127.0.0.1:8000','Access-Control-Request-Method':'POST','Access-Control-Request-Headers':'Content-Type'})
r=conn.getresponse()
print(r.status, r.reason)
print(dict(r.getheaders()))
conn.close()
