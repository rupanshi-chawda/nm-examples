# Installing JupyterLab-Github Extension to access Github Repositories 
This extension allows you to select GitHub organizations and users, browse their repositories, and open the files in those repositories. 
If the repo contains notebooks, then you can run them. On installation an additional filebrowser tab will be added to the left side bar of JupyterLab.

</br>

>This extension enables us to load files from Github directly 
>instead of Google Storage where we need to first upload the files to load into the Docker image, eliminating the extra work.

## Requirements 
- Jupyterlab 1.0
- A GitHub account for the server extension

## Installation

### 1. Editing Dockerfile to Install server extension 

Add the following lines to the Dockerfile -

To Install the serverextension using pip, and then enable it:
``` 
pip install jupyterlab_github 
```

If you are running Notebook 5.2 or earlier, enable the server extension by running
``` 
jupyter serverextension enable --sys-prefix jupyterlab_github 
```
##### The Dockerfile should look like this -
![imageedit_2_7368872777](https://user-images.githubusercontent.com/58527347/147265031-1b999e96-38f5-4619-84fe-21260543c741.gif)
</br>

### 2. Build the Docker Image and Push it to Dockerhub
- Upload the edited Dockerfile into the staging VM. </br>
- Build Dockerfile: Assuming you are situated in your user directory,
```
sudo docker build -f Dockerfile .
```
- Push the Docker image to Dockerhub. You can follow [Push the Docker image to DockerHub](https://github.com/nmltd/s2-dev/blob/cicd-setup/docs/testing_staging.md#push-the-docker-image-to-dockerhub).


### 3. Configure the Yaml File
- Open the staging cluter `name-cluter`, select "Connect", and click "Run in cloud shell".
- To modify the configuration file for example - your server is at https://s33.nm.dev : 
```
$ nano config-s33.yaml
```
- Add the following changes to the configuration file -

![imageedit_7_8861104518](https://user-images.githubusercontent.com/58527347/147268904-9f621c65-ae91-4aad-a154-73357f6284e3.jpg)
</br> Image `name` and `tag` are of the new image you pushed before. </br>

### 4. Deploy to Kubernetes
You can follow [Deploying S2 to Google Cloud](https://github.com/nmltd/s2-dev/blob/cicd-setup/docs/deploying_to_kubernetes.md), or 
- First, install and update the JupyterHub Helm chart:
```
$ helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
$ helm repo update
```
- Rollback the previous version before `helm upgrade`.
```
$ helm  list
$ helm rollback s33 1
```
- Now, do
```
$ helm upgrade --cleanup-on-fail --install s33 jupyterhub/jupyterhub --version=0.9.0 --values config-s33.yaml --timeout 10m0s
```
- To obtain the external allocated IP address, do
```
$ kubectl get svc proxy-public
```

## How to use the extension 
After deploying, your Jupyterhub will look like this.
![image](https://user-images.githubusercontent.com/58527347/147270750-e5f0674c-b099-452b-978d-4a33c0486551.png)

</br>

You can search any **public** repository by searching `owner/repo-name` in the github-user tab.
</br>

## Access private repositories 
To access private repos, you need to generate Github Access Token. </br>
You can get an access token by following these steps:
- Verify your email address with GitHub.
- Go to your account settings on GitHub and select "Developer Settings" from the left panel.
- On the left, select "Personal access tokens"
- Click the "Generate new token" button, and enter your password.
- Give the token a description, and check the "repo" scope box.
- Click "Generate token"
- You should be given a string which will be your access token.

</br>

Remember that this token is effectively a password for your GitHub account. Do not share it online or check the token into version control,
as people can use it to access all of your data on GitHub. </br>
You now need to add the credentials you got from GitHub to your notebook configuration file. 
Instructions for generating a configuration file can be found here. Once you have identified this file, add the following lines to it:
```
c.GitHubConfig.access_token = '< YOUR_ACCESS_TOKEN >'
```
where `"< YOUR_ACCESS_TOKEN >"` is the string value you obtained above after generating access token.
