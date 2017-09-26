# Docker Images for Common Dev/Production Environment

There are 3 docker images available: **python2**, **python2-teradata**, **python3**, **python3-teradata**, **jupyter-python-ultra-pack**.


### python2
```bash
docker pull raychee/python2
```
This image is based on *CentOS 7*, bundled with [miniconda](https://conda.io/miniconda.html) (the minimized version of [Anaconda](https://www.continuum.io/downloads)). 
That means ```python``` (version 2.7) and ```pip``` are already available. 
```conda``` is also available of course, and it is recommended for package management over ```pip```. 
To learn more about ```conda```, please check out its [homepage](https://www.continuum.io/).

- ```docker run -it raychee/python2```  
enters the ```bash``` shell in CentOS 7 and you are good to go.
 
- ```docker run --rm -v `pwd`:/src raychee/python2 python /src/<your_script_in_local_dir>.py```  
can run a script in your current local directory, with ```python``` in the docker environment.


### python2-teradata
```bash
docker pull raychee/python2-teradata
```
This image is based on **python2**, with additional Teradata ODBC driver installed. 
Specifically, the driver includes Teradata Linux Driver, and *teradata* the python package.

Here is an example code snippet for connecting to Teradata with python (run in docker):
```python
import teradata
uda = teradata.UdaExec(appName='whatever', version='1.0')
session = uda.connect(method='odbc', system='<www.host_server.com>', username='<your_name>', password='<your_password>')
query = session.execute('SELECT * FROM table')
result = query.fetchall()
```
(There is an even simpler solution for connecting to Teradata, but for python 3 only: [here](#qutils))

### python2-teradata-ldap
```bash
docker pull rexren/python2-teradata-ldap
```
This image is based on **python2-teradata**, with additional ldap related packages installed.
You can type ```import ldap``` to use python-ldap.


### python3
```bash
docker pull raychee/python3
```
This image is identical to **python2** except that the python version is 3.6. 


### python3-teradata
```bash
docker pull raychee/python3-teradata
```
This image is identical to **python2-teradata** except that the python version is 3.6.

<a name="qutils"></a> By the way, there is an even simpler and more friendly solution to connect to teradata (for python *3* only): firstly ```pip install qutils``` in bash, and then in python
```python
from qutils.iotools import Teradata
tera = Teradata('<www.host_server.com>', '<your_user_name>', '<your_password>')
result = tera.query('SELECT * FROM table')
```
This ```result``` will be a Pandas DataFrame.

### jupyter-python-ultra-pack
```bash
docker pull raychee/jupyter-python-ultra-pack
```
This is an ALL-in-ONE image based on **python3-teradata**. 
It includes *python 2.7*, *python 3.6*, *Anaconda*, Teradata Linux Driver, *xgboost* (0.6), and a pre-configured *jupyter notebook*.

- ```docker run -d -p 8888:8888 -v `pwd`:/jupyter raychee/jupyter-python-ultra-pack```  
starts a jupyter server in local host which will be listening on all open IP login requests.  
For example, you can deploy it on C3 and open [http://<your_c3_host>:8888]() with your local computer to run any python code on C3.  
The python *2* and *3* kernels are already available; you can feel free to switch it.


## Feedback
Please feel free to try it and let me know any issues when you are using the images.
