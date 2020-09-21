# Get Mercadolibre / Tu Carro access token
1. Ingrese como administrador a mercadolibre
2. Copie y pegue la siguiente URL en su explorador
   `http://auth.mercadolibre.com.co/authorization?response_type=code&client_id=6183539405320299&redirect_uri=https://www.retomautos.com/`
3. Acepte los permisos
4. Será redirigido a retomautos.
5. Tome note del texto despues de `code=` en la url. Llamaremos esto
   `SERVER_GENERATED_AUTHORIZATION_CODE`
6. Intercambie el `SERVER_GENERATED_AUTHORIZATION_CODE` por un
   `access_token` y un `refresh_token`


```shell script
   curl -X POST \
-H 'accept: application/json' \
-H 'content-type: application/x-www-form-urlencoded' \
'https://api.mercadolibre.com/oauth/token' \
-d 'grant_type=authorization_code' \
-d 'client_id=6183539405320299' \
-d 'client_secret=Cza9ilXdL3TJ3RvuoWNK5gpQDGqBK2m8' \
-d 'code=$SERVER_GENERATED_AUTHORIZATION_CODE' \
-d 'redirect_uri=https://www.retomautos.com/'
```
Nota: hay un request the postman salvado para este paso.

```json
{
    "access_token": "APP_USR-123456-090515-8cc4448aac10d5105474e1351-1234567",
    "token_type": "bearer",
    "expires_in": 10800,
    "scope": "offline_access read write",
    "user_id":1234567,
    "refresh_token": "TG-5b9032b4e23464aed1f959f-1234567"
}

```

7. Tome nota del access token, del refresh_token y del expires in
8. Utilice el api de refresh token cada menos de 6 horas para renovar el
   access_token. Tome nota del refresh_token de regreso para la
   siguiente renovación

```shell script
curl -X POST \
-H 'accept: application/json' \
-H 'content-type: application/x-www-form-urlencoded' \
'https://api.mercadolibre.com/oauth/token' \
-d 'grant_type=refresh_token' \
-d 'client_id=$APP_ID' \
-d 'client_secret=$SECRET_KEY' \
-d 'refresh_token=$REFRESH_TOKEN'

```

```ruby

mercadolibre_api = Mercadolibre::Api.new(access_token: "APP_USR-6183539405320299-092012-449f1dadfbd72e4ff495295551460780-28140600", app_key: '6183539405320299', app_secret: 'Cza9ilXdL3TJ3RvuoWNK5gpQDGqBK2m8')
refresh_result = mercadolibre_api.update_token(refresh_token)
refresh_result.access_token
# => "APP_USR-6183539405320299-092013-993cff398a29e330b2f5397d72b186c6-28140600"
refresh_result.refresh_token 
# => "TG-5f674ae1967bd500079afd85-28140600"
refresh_result.expiration_time
# => 2020-09-21 05:21:08 +1000

```

```
{
    "access_token": "APP_USR-12345657984-090515-b0ad156bce70050973466faa15-1234567",
    "token_type": "bearer",
    "expires_in": 10800,
    "scope": "offline_access read write",
    "user_id":1234567,
    "refresh_token": "TG-5b9032b4e4b0714aed1f959f-1234567"
}
```
