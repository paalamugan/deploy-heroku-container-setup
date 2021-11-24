# Setup Instructions For Deploy Application In Heroku Container

- How to setup react application using heroku container via docker cli.

## Get Started

- Install dependencies
```
yarn install
```

- For development,
```
yarn run start
```

- For production build,
```
yarn run build
```

## Deploy react application using heroku container cli

- [Installation heroku instructions](https://devcenter.heroku.com/articles/heroku-cli)

- Go to your root of the project folder and use below commands,
    ```sh
    heroku login
    heroku plugins:install heroku-container-registry
    heroku create ${YOUR_APP_NAME}
    heroku container:login
    heroku container:push web --app ${YOUR_APP_NAME}
    heroku container:release web --app ${YOUR_APP_NAME}
    heroku open --app ${YOUR_APP_NAME}
    ```

- Automatically deploy new changes to heroku after pushing to main branch, for example

```sh
git add heroku.yml
git commit -m "Add heroku.yml"
```

- Set the stack of your app to container: (Only once)
```sh
heroku stack:set container
```

- Push your app to Heroku:
```sh
git push heroku <branch_name>
```

- After pushing to heroku, it will use the run command provided in `heroku.yml` instead of your `Procfile`.

## Push Updated code to heroku using docker cli

- Initial setup (Only once).
```sh
docker login --username=_ --password=$(heroku auth:token) registry.heroku.com
```

- Create a tag `registry.heroku.com/${YOUR_APP_NAME}/web` that refers to `${EXISTING_IMAGE_NAME}` 

```sh
docker tag ${EXISTING_IMAGE_NAME} registry.heroku.com/${YOUR_APP_NAME}/web
```

- Build docker image again with new changes. 
```sh
docker build -t registry.heroku.com/${YOUR_APP_NAME}/web .
```

- Push the new local changes to production
```sh
docker push registry.heroku.com/${YOUR_APP_NAME}/web
```

- When running a Docker container locally, you can set an environment variable using the -e flag:

```sh
docker run -p 8080:80 -e PORT=80 ${IMAGE_NAME}
```

 - Mutiple environment setup
 ```sh
 docker run -p 8080:80 --env-file .env ${IMAGE_NAME}
 ```
