##关于license制作系统源码
源码现存放于不可描述的地方

现保留系统提供一个后台管理接口，使用python manage.py shell 进入（flask-migrate实现）

##关于license制作系统的部署

现目前license系统是采用flask网络框架，部署采用apache+wsgi的方式。

####关于部署的一些细节问题

- 须在项目根目录新建文件licms.wsgi，内容为：
```python
import os
import sys
sys.path.append('/var/www/licms/')
from manage import app as application
```

- 项目中部署的文件存储位置配置
  - 在路径``app/viewConfig/config.py``中配置有文件存储路径，修改路径需保证该路径存在且具有读写权限
  - 在路径``app/comm/lic.py``中配置有临时文件路径，修改路径需保证该路径存在且具有读写权限

- 项目采用服务器软件采用apache, http配置的内容部分如下(若需配置值https则相似)：
```
<VirtualHost *:80>
     ServerName localhost:80

     WSGIDaemonProcess licms user=licms group=licms threads=10
     WSGIScriptAlias / /var/www/licms/licms.wsgi
     WSGIScriptReloading On

     <Directory /var/www/licms>
         WSGIProcessGroup licms
         WSGIApplicationGroup %{GLOBAL}
         Order deny,allow
         Allow from all
     </Directory>
</VirtualHost>
```

- 若需要邮件到期通知需开启``rabbitmq-server``与``celery``, 可使用``supervisor``管理``celery``进程，``supervisor``的配置如下（supervisor的使用请自寻查询）：

```
[program:celerymail]
command=celery -A manage.celery worker -B --loglevel=info
;command=celery -A worker manage.celery -B --loglevel=info
directory=/var/www/licms/
user=licms
numprocs=1
stdout_logfile=/home/licms/log/celerylog/celery_beat.log
stderr_logfile=/home/licms/log/celerylog/celery_beat.err
autostart=true
autorestart=true
startsecs=60
priority=999
stopsignal=KILL
stopasgroup=true
```
- 邮件的发件人与收件人在根目录的``celeryconfig.py``文件中配置，发件人的用户名与密码也可以在其中配置或在用户(启动supervisor的用户)目录``.bashrc``文件中配置。（有密码泄漏的危险，我也没办法）
