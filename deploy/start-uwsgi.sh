. bin/activate
uwsgi \
    --chdir="/opt/mach-env/construct" \
    --module=construct.wsgi:application \
    --env DJANGO_SETTINGS_MODULE=construct.settings \
    --master --pidfile=/tmp/construct-master.pid \
    --socket=127.0.0.1:8001 \
    --processes=1 \
    --uid=1000 --gid=2000 \
    --harakiri=20 \
    --max-requests=5000 \
    --vacuum \
    --home="/opt/mach-env"

#--daemonize=/var/log/uwsgi/construct.log
