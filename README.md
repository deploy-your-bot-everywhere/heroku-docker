# Deploy a bot with Docker on Heroku

1. Регистрируемся на [Heroku](https://signup.heroku.com/)

2. Качаем [Heroku CLI](https://devcenter.heroku.com/articles/getting-started-with-python#set-up)

3. Если не установлен Docker, самое время [перейти по ссылке](https://docs.docker.com/install/)

4. Клонируем репозиторий**
  ```bash
  git clone https://github.com/deploy-your-bot-everywhere/heroku-docker.git
  cd heroku-docker 
  ```
5. Логинимся
```bash
╰─ heroku login
heroku: Enter your login credentials
Email : example@gmail.com
Password: ******
Logged in as example@gmail.com
```
6. Создаем приложение
```bash
╰─ heroku create --region eu deploy-heroku-bot                          
Creating ⬢ deploy-heroku-bot... done, region is eu
https://deploy-heroku-bot.herokuapp.com/ | https://git.heroku.com/deploy-heroku-bot.git
```
7. Добавляем токен нашего бота 
```bash
╰─ heroku config:set TOKEN=123429417:AAEG39dbtyy4UrUDkvE7L5hIKuoIuQp9pfs
Setting TOKEN and restarting ⬢ deploy-heroku-bot... done, v3
TOKEN: 123429417:AAEG39dbtyy4UrUDkvE7L5hIKuoIuQp9pfs
```
8. Логинимся в **Container Registry**
```bash
╰─ heroku container:login
Login Succeeded
```
9. Пушим наше Docker приложение
```bash
╰─ heroku container:push web
=== Building web (/home/heyyyoyy/deploy-your-bot-everywhere/Dockerfile)
Sending build context to Docker daemon  112.1kB
Step 1/8 : FROM python:3.7-alpine
 ---> 408808fb1a9e
Step 2/8 : ENV TOKEN $TOKEN
 ---> Using cache
 ---> df51142b78f3
Step 3/8 : ENV PORT $PORT
 ---> Using cache
 ---> f55fd3d9eaff
Step 4/8 : ADD ./requirements.txt /tmp/requirements.txt
 ---> Using cache
 ---> 6f8e2f922d00
Step 5/8 : RUN pip install -r /tmp/requirements.txt
 ---> Using cache
 ---> 29e3d920ec22
Step 6/8 : ADD ./main.py /opt/main.py
 ---> Using cache
 ---> e36191b406bd
Step 7/8 : WORKDIR /opt
 ---> Using cache
 ---> 7f33aff92f9a
Step 8/8 : CMD ["python", "main.py"]
 ---> Using cache
 ---> a4ce41de9be5
Successfully built a4ce41de9be5
Successfully tagged registry.heroku.com/deploy-heroku-bot/web:latest
=== Pushing web (/home/heyyyoyy/deploy-your-bot-everywhere/Dockerfile)
The push refers to repository [registry.heroku.com/deploy-heroku-bot/web]
84c9c852f55e: Pushed 
93433d258180: Pushed 
d7b90206ee68: Pushed 
9473be8f0aba: Pushed 
5d456d0e47c6: Pushed 
915ce695708c: Pushed 
beefb6beb20f: Pushed 
df64d3292fd6: Pushed 
latest: digest: sha256:2ead7db8d56a57364c691f51ccf49483ba7b3803eb46e8525d17d25fc04be088 size: 1994
Your image has been successfully pushed. You can now release it with the 'container:release' command.
```
10. Деплоим наши изменения
```bash
╰─ heroku container:release web
Releasing images web to deploy-heroku-bot... done
```
11. Проверяем, что все работает
```bash
╰─ heroku ps
Free dyno hours quota remaining this month: 548h 18m (99%)
Free dyno usage for this app: 0h 0m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

=== web (Free): python main.py (1)
web.1: up 2018/11/04 22:03:14 +0300 (~ 11s ago)
```
