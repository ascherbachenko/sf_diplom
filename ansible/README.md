Адреса, как писалось ранее, будут доступны после сборки terraform в OUTPUT.

Файл inventory.ini

[master]
ip adress master-0

[app]
ip adress app-0

[srv]
ip adress srv-0

[kuber]
ip adress master-0
ip adress app-0

1. Проверить доступ по ssh через ключи ко всем серверам
2. Запустить pipeline Install_other_app.yaml, который поставит все дополнительное ПО
3. Запустить pipeline Install_kuber.yaml, который подготовить master и node к включению в кластер
4. На сервере master-0 нужно запустить следующие команды, скопирова после инициализации кластера команду присоединения в кластер ноды:

   sudo kubeadm init --control-plane-endpoint=master-0
   mkdir -p $HOME/.kube
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   sudo chown $(id -u):$(id -g) $HOME/.kube/config

5. На сервере worker-0 выполнить команду скопированную при инициализации сервера, пример ниже:

    sudo kubeadm join master-0:6443 --token <your_token> \
	--discovery-token-ca-cert-hash sha256: <your_hash>

     
