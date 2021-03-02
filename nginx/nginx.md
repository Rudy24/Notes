### Nginx学习笔记

Nginx是一个高性能的HTTP和反向代理服务器，以高稳定性、丰富的功能集、示例配置文件和低系统资源的消耗而闻名

#### 虚拟主机

##### 介绍

虚拟主机使用的是特殊的软硬件技术，把一台运行在因特网上的服务器主机分成多台"虚拟"的
主机，每台虚拟主机是一个独立的网站，具有独立的域名，具有完整的Intemet服务器功能
（WWW、FTP、Email等）。同一台主机上的虚拟主机之间是完全独立的，在网站访问者看
来，每一台虚拟主机和一台独立的主机是完全一样。
总结：虚拟主机提供了在同一台服务器、同一个 Nginx 进程上运行多个网站的功能。
PS: 虚拟主机和虚拟机是两个不同的概念，不要搞混了[虚拟机与虚拟主机的区别](https://blog.csdn.net/firefly_2002/article/details/8070502)

#### 支持

Nginx可以配置多种类型的虚拟主机。

#### upstream

upstream设置中，有个参数要特别的小心，就是这个keepalive
将keepalive设置为这个长连接数量的10%到30%。
比较懒的同学，可以直接设置为keepalive=1000之类的，一般都OK的了。

####  nginx如何处理请求

#### 基于名称的虚拟服务器

nginx首先要决定哪个服务器应该处理请求。让我们从一个简单的配置开始，三个虚拟服务器
都监听在端口*:80:

    server {
      listen 80;
      server_name example.org www.example.org;
      ...
    }

    server {
      listen 80;
      server_name example.net www.example.net;
      ...
    }

    server {
      listen 80;
      server_name example.com www.example.com;
      ...
    }

在这个配置中，nginx仅仅检验请求header中的"Host"域来决定请求应该路由到哪个服务器。
如果它的值不能匹配任何服务器，或者请求完全没有包含这个header域，那么nginx将把这个
请求路由到这个端口的默认服务器。在上面的配置中，默认服务器是第一个 - 这是nginx标准
的默认行为。也可以通过listen指令的default_server属性来显式的设置默认服务器:


    server {
      listen 80 default_server;
      server_name example.net www.example.net;
      ...
    }


###### 基于名称和基于IP混合的虚拟服务器

让我们看一下更复杂的配置，有一些虚拟服务器监听在不同的地址：

    server {
      listen 192.168.1.1:80;
      server_name example.org www.example.org;
      ...
    }
    server {
      listen 192.168.1.1:80;
      server_name example.net www.example.net;
      ...
    }
    server {
      listen 192.168.1.2:80;
      server_name example.com www.example.com;
      ...
    }


### 使用nginx实现HTTP负载均衡

在多个应用实例间做负载均衡是一个被广泛使用的技术，用于优化资源效率，最大化吞吐
量，减少延迟和容错
nginx可以作为一个非常高效的HTTP负载均衡器来分发请求到多个应用服务器，并提高web应
用的性能，可扩展性和可靠性。

####负载均衡方法

nginx支持以下负载均衡机制（或者方法）：
+ round-robin/轮询： 到应用服务器的请求以round-robin/轮询的方式被分发
+ least-connected/最少连接：下一个请求将被分派到活动连接数量最少的服务器
+ ip-hash/IP散列： 使用hash算法来决定下一个请求要选择哪个服务器(基于客户端IP地址

#### 默认负载均衡配置(轮询)
nginx中最简单的负载均衡配置看上去大体如下：

    http {
      upstream myapp1 {
        server srv1.example.com;
        server srv2.example.com;
        server srv3.example.com;
      }
      server {
        listen 80;
        location / {
          proxy_pass http://myapp1;
        }
      }
    }

在上面的例子中， 同一个应用有3个实例分别运行在srv1-srv3。当没有特别指定负载均衡方
法时， 默认为round-robin/轮询。所有请求被代理到服务器集群myapp1， 然后nginx实现
HTTP负载均衡来分发请求。
在nginx中反向代理的实现包括HTTP, HTTPS, FastCGI, uwsgi, SCGI, 和 memcached的负载
均衡。

要配置负载均衡用HTTPS替代HTTP，只要使用"https"作为协议即可。
为FastCGI, uwsgi, SCGI, 或 memcached 搭建负载均衡时， 只要使用相应的fastcgi_pass,
uwsgi_pass, scgi_pass, 和 memcached_pass指令。

#### 最少连接负载均衡

另一个负载均衡方式是least-connected/最少连接。当某些请求需要更长时间来完成时，最少
连接可以更公平的控制应用实例上的负载。
使用最少连接负载均衡时，nginx试图尽量不给已经很忙的应用服务器增加过度的请求， 而是
分配新请求到不是那么忙的服务器实例。
nginx中通过在服务器集群配置中使用least_conn指令来激活最少连接负载均衡方法：

    
    upstream myapp1 {
      least_conn;
      server srv1.example.com;
      server srv2.example.com;
      server srv3.example.com;
    }


#### 会话持久化(ip-hash)

请注意，在轮询和最少连接负载均衡方法中，每个客户端的后续请求被分派到不同的服务
器。对于同一个客户端没有任何方式保证发送给同一个服务器。

如果需要将一个客户端绑定给某个特定的应用服务器——用另一句话说，将客户端会话"沾
住"或者"持久化"，以便总是能选择特定服务器——，那么可以使用ip-hash负载均衡机制。

使用ip-hash时，客户端IP地址作为hash key使用，用来决策选择服务器集群中的哪个服务器
来处理这个客户端的请求。这个方法保证从同一个客户端发起的请求总是定向到同一台服务
器，除非服务器不可用。

要配置使用ip-hash负载均衡，只要在服务器集群配置中使用ip_hash指令：

    upstream myapp1 {
      ip_hash;
      server srv1.example.com;
      server srv2.example.com;
      server srv3.example.com;
    }


#### 带权重的负载均衡

可以通过使用服务器权重来影响nginx的负载均衡算法。

在上面的例子中，服务器权重没有配置，这意味着所有列出的服务器被认为对于具体的负载
均衡方法是完全平等的。

特别是轮询，分派给服务器的请求被认为是大体相当的——假设有足够的请求，并且这些请
求被以同样的方式处理而且完成的足够快。

当服务器被指定weight/权重参数时，负载均衡决策会考虑权重。

    upstream myapp1 {
      server srv1.example.com weight=3;
      server srv2.example.com;
      server srv3.example.com;
    }

在这个配置中，每5个新请求将会如下的在应用实例中分派： 3个请求分派去srv1,一个去srv2,
另外一个去srv3.

在最近的nginx版本中，可以类似的在最少连接和IP哈希负载均衡中使用权重