# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `yarn start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.\
You will also see any lint errors in the console.

### `yarn test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `yarn build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `yarn eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

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

- Your application will be built, and Heroku will use the run command provided in **heroku.yml** instead of your **Procfile**.

## Push Updated code to heroku with using docker cli

- Initial setup (Only once).
```sh
docker login --username=_ --password=$(heroku auth:token) registry.heroku.com
```

- Create a tag `registry.heroku.com/${YOUR_APP_NAME}/web` that refers to `${EXISTING_IMAGE_NAME}` 

```sh
docker tag ${EXISTING_IMAGE_NAME} registry.heroku.com/${YOUR_APP_NAME}/web
```

- Build docker image with new changes. 
```sh
docker build -t registry.heroku.com/${YOUR_APP_NAME}/web .
```

- Push the new changes to live
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
