# CHANGE TO docker-compose.yaml

 open docker-compose.yaml and make the following changes:

---

change the value of the environment variable **ncwmspassword** from "customncwmspassword" to the password you want to use for the ncWMS service

---

change the path on the line: 

<pre>- source: C:\ETT\github\docker-ncwms-install\deployfiles\entrypoints\ncWMS_entrypoint.sh</pre>

to the actual folder where you have deployed the ncWMS_entrypoint.sh file

---

change the path on the line: 

<pre>- source: C:\ETT\github\docker-ncwms-install\deployfiles\configs\ncWMS.xml</pre>

to the actual folder where you have deployed the ncWMS.xml file 

---

change the path on the line: 

<pre>- source: C:\ETT\github\docker-ncwms-install\volumes\ncwmsData</pre>

to a folder where you want to store ncWMS configuration files

---

change the port on the line:

<pre>- published: 12083</pre>

to the port you want to use for the ncWMS service


# HOW TO RUN

execute the command

<code>docker-compose up -d </code>

on the folder where you have deployed the docker-compose.yaml file

# HOW TO CONFIGURE ncWMS FOR ERDDAP DATASETS

1. open a browser and go to the URL: http://server-address/ncWMS2/admin
2. login with the username: ncwms and the password you have set in the docker-compose.yaml file
3. to configure a ERDDAP datset put the url of a gridded datasets in the feld "Location", add a ID (we suggest to use the dataset ID), the Title and fill all other fileds if needed

    For example if you want to setup ncWMS for the dataset:<br>https://erddap.emodnet-physics.eu/erddap/griddap/ERD_EP_CURR_DNS.html 
     
     you should put in the Location field: <br>https://erddap.emodnet-physics.eu/erddap/griddap/ERD_EP_CURR_DNS
1. Push "Save configuration" button

# TROUBLESHOOTING


