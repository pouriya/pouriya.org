+++
title = "About"
date  = 2019-01-01T00:00:00
+++

{{< highlight python >}}

class About:

    def name(self):
        return "Pouriya Jahanbakhsh"

    def job(self):
        return "Software Programmer"

    def programming_languages(self):
        # The ability to get things done
        # min: 1 & max: 5
        return {
            "Erlang/OTP": 5,
            "Python":     4,
            "AWK":        4,
            "C":          3,
            "Elixir":     3,
            "Sh":         3,
            "Ruby":       2,
            "Perl":       1,
            "Go":         1,
            "Rust":       1
        }

    def operating_systems(self):
        return {"FreeBSD": 3, "GNU/Linux": 2}

    def databases(self):
        return {
            "Cassandra": 3,
            "Influxdb":  3,
            "MySQL":     3,
            "MariaDB":   3
        }

    def message_brokers(self):
        return {
            "Ejabberd":   5,
            "MongooseIM": 3,
            "Kafka":      3,
            "nats":       2,
            "nsq":        2
        }

    def techinal_skills(self):
        return {
            "Functional programming":  4,
            "Socket programming":      4,
            "Test Driven Development": 4,
            "Monitoring":              3
        }

    def country(self):
        return "Iran"

    def email(self):
        return "pouriya.jb" + "@" + "gmail.com"

    def phone_number():
        return "+989195458500"

    def github(self):
        return "https://github.com/pouriya"

	def linkedin(self):
		return "https://www.linkedin.com/in/pouriya-jahanbakhsh"

	def twitter(self):
		return "https://twitter.com/mr_pouriya"

	def donate(self):
		print("Thanks!")
		return "https://idpay.ir/jahanbakhsh"

{{< / highlight >}}

<br/>
# Open Source projects
I do love coding things and especially building OSS (Open-Source Software).<br/><br/><br/>

### <a href="https://github.com/pouriya/emeter" target="_blank" style="color:#204A87">EMeter </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=emeter&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Fast and pluginable monitoring tool for Erlang ecosystem. <br/><br/><br/>

### <a href="https://github.com/pouriya/director" target="_blank" style="color:#204A87">director </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=director&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Director is a production-ready supervisor and manager for Erlang/Elixir processes that focuses on speed, performance and flexibility.<br/><br/><br/>

### <a href="https://github.com/pouriya/tir" target="_blank" style="color:#204A87">tir </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=tir&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Have time.ir in shell!<br/><br/><br/>

### <a href="https://github.com/pouriya/sockerl" target="_blank" style="color:#204A87">sockerl </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=sockerl&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Sockerl is an Erlang/Elixir socket framework for TCP protocols and provides fast, useful and easy-to-use API for implementing servers, clients and client connection pools.<br/><br/><br/>

### <a href="https://github.com/pouriya/pipeline" target="_blank" style="color:#204A87">pipeline </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=pipeline&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Use -- operatior for function call chaining in Erlang.<br/><br/><br/>

### <a href="https://github.com/pouriya/estuff" target="_blank" style="color:#204A87">estuff </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=estuff&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
An Erlang rebar3 template for making new Erlang/OTP project.<br/><br/><br/>

### <a href="https://github.com/pouriya/posthaste" target="_blank" style="color:#204A87">posthaste </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=posthaste&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Blazingly fast Erlang/Elixir hooking library. <br/><br/><br/>

### <a href="https://github.com/pouriya/gen_fw" target="_blank" style="color:#204A87">gen_fw </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=gen_fw&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Erlang/Elixir Generic firewall process. <br/><br/><br/>

### <a href="https://github.com/pouriya/pcommit" target="_blank" style="color:#204A87">pcommit </a><iframe src="https://ghbtns.com/github-btn.html?user=pouriya&repo=pcommit&type=star&count=true" frameborder="0" scrolling="0" width="170px" height="20px"></iframe>
Python script that handles my Git commit messages.

<br/><br/>
# Open Source contributions
<br/>

### [Erlang/OTP](http://erlang.org)
I Fixed a bug in stdlib's **sys** module and added a new feature to it. [**Link to Pull-Request**](https://github.com/erlang/otp/commit/eefcc985530acbd5cc4c97b6e4f537492fd61622)  
<br/>
<br/>


### [Ejabberd](https://ejabberd.im)
I added a new hook to detect XMPP's component packets. [**Link to Pull-Request**](https://github.com/processone/ejabberd/commit/7b3d26992b492063d6a6c2af3c595934d681accc) 
<br/>
<br/>


### [Warp (self-contained single binary maker)](https://github.com/dgiagio/warp)
I added a complete Erlang example. [**Link to Pull-Request**](https://github.com/dgiagio/warp/commit/bb2364dc9de3739fe96d1e1aa8bb941060ed4aba)
<br/>
<br/>


### Client encoder for [InfluxDB](https://docs.influxdata.com/influxdb/v1.7/tools/api_client_libraries/#erlang) & [OpenTSDB](http://opentsdb.net/docs/build/html/api_telnet/put.html) & [Graphite](https://graphite.readthedocs.io/en/latest/feeding-carbon.html#the-plaintext-protocol)
[**InfluxDB Repository**](https://github.com/pouriya/influxdb_encoderl)  
[**OpenTSDB Repository**](https://github.com/pouriya/opentsdb_encoderl)  
[**Graphite Repository**](https://github.com/pouriya/graphite_encoderl)
<br/>
<br/>


### [ejabberdctl bash completion](https://docs.ejabberd.im/admin/ejabberdctl/)
[**Link to Repository**](https://github.com/pouriya/ejabberdctl_bash_completion)
<br/>
<br/>
