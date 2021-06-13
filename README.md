<h1 class="code-line" data-line-start=0 data-line-end=1 ><a id="Objective_Kubernetes_cluster_setup_using_Ansible_0"></a>Objective: Kubernetes cluster setup using Ansible</h1>
<p class="has-line-data" data-line-start="2" data-line-end="3"><a href="https://travis-ci.org/joemccann/dillinger"><img src="https://travis-ci.org/joemccann/dillinger.svg?branch=master" alt="Build Status"></a></p>
<h2 class="code-line" data-line-start=3 data-line-end=4 ><a id="Description_3"></a>Description:</h2>
<hr>
<p class="has-line-data" data-line-start="5" data-line-end="6">In my project, I have used an EC2 instance with CentOS AMI and installed Ansible on it. Also for the Kube servers, I have chosen the same AMI. The next thing to do is to set up passwordless authentication between the Ansible server and the K8’s servers. I have created a script to avoid configuring the Ansible hosts manually and it will also verify the connection to the Kube servers are faultless. The script will ask for some details such as the public IP of K8’s Master, no. of K8’s Nodes for the cluster, and the public IPs of those nodes. After that, I have initialized the Ansible roles and created the Yaml files to set up the Kube cluster. The Yaml file consists of installing services and dependencies, also to satisfy the Kubernetes requirements I have used “Flannel” as an Overlay Network. The interesting fact is that I’m not touching the K8’s master and its nodes for configuring. The execution of the playbook will result in the K8’s cluster formation within 10 mins (PS: If you have a good internet connection).</p>
<h2 class="code-line" data-line-start=8 data-line-end=9 ><a id="Prerequisite_8"></a>Prerequisite:</h2>
<hr>
<ul>
<li class="has-line-data" data-line-start="10" data-line-end="11">A server with Ansible installed.</li>
<li class="has-line-data" data-line-start="11" data-line-end="12">A server for K8’s Master and ‘n’ no.of nodes (You can specify any no.of K8’s nodes)</li>
<li class="has-line-data" data-line-start="12" data-line-end="14">Public IP address of K8’s Master and ‘n’ nodes</li>
</ul>
<h2 class="code-line" data-line-start=14 data-line-end=15 ><a id="Steps_14"></a>Steps:</h2>
<hr>
<ul>
<li class="has-line-data" data-line-start="16" data-line-end="17">Step 1: Installed Ansible on a CentOS server.</li>
<li class="has-line-data" data-line-start="17" data-line-end="18">Step 2: Made passwordless authentication with the Ansible server and the K8’s servers.</li>
<li class="has-line-data" data-line-start="18" data-line-end="19">Step 3: Ran the script <strong><a href="http://configure.sh">configure.sh</a></strong> which is present under the root directory.</li>
<li class="has-line-data" data-line-start="19" data-line-end="23">Step 4: The script will ask for the details such as:
<ol>
<li class="has-line-data" data-line-start="20" data-line-end="21">The public IP address of K8’s master</li>
<li class="has-line-data" data-line-start="21" data-line-end="22">No.of Kube nodes which you want to use for the cluster.</li>
<li class="has-line-data" data-line-start="22" data-line-end="23">The public IP address of “n” no. of nodes</li>
</ol>
</li>
<li class="has-line-data" data-line-start="23" data-line-end="24">Step 5: If the connections are perfect the script will show the ping result to the K8’s master and its nodes as an output.</li>
<li class="has-line-data" data-line-start="24" data-line-end="25">Step 6: Initialize the Ansible roles.</li>
<li class="has-line-data" data-line-start="25" data-line-end="27">Step 7: Run the setup.yml file with the Ansible playbook command.</li>
</ul>
<h2 class="code-line" data-line-start=27 data-line-end=28 ><a id="Installation_27"></a>Installation:</h2>
<hr>
<p class="has-line-data" data-line-start="29" data-line-end="30">Installing Ansible on CentOS server:</p>
<pre><code class="has-line-data" data-line-start="31" data-line-end="34" class="language-sh">$ sudo yum update -y
$ sudo yum install ansible -y
</code></pre>
<p class="has-line-data" data-line-start="34" data-line-end="36">This would successfully install the ansible.<br>
Also recommended to do an update after the installation of ansible</p>
<h2 class="code-line" data-line-start=37 data-line-end=38 ><a id="File_Locations_37"></a>File Locations:</h2>
<hr>
<p class="has-line-data" data-line-start="39" data-line-end="40">The Shell Script and Yaml file are present under the directory named cluster.</p>
<pre><code class="has-line-data" data-line-start="41" data-line-end="48" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> cluster]<span class="hljs-comment"># pwd</span>
/root/cluster
[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> cluster]<span class="hljs-comment"># ll</span>
total <span class="hljs-number">8</span>
-rwx------. <span class="hljs-number">1</span> root root <span class="hljs-number">1143</span> Jun <span class="hljs-number">11</span> <span class="hljs-number">11</span>:<span class="hljs-number">02</span> configure.sh
-rw-r--r--. <span class="hljs-number">1</span> root root  <span class="hljs-number">109</span> Jun <span class="hljs-number">11</span> <span class="hljs-number">06</span>:<span class="hljs-number">30</span> setup.yml
</code></pre>
<h2 class="code-line" data-line-start=49 data-line-end=50 ><a id="Initializing_Ansible_roles_49"></a>Initializing Ansible roles:</h2>
<hr>
<p class="has-line-data" data-line-start="51" data-line-end="53">Ansible-galaxy is the command to be used to re-define the Ansible roles<br>
I have initialized two roles, one for K8’s Master and one for K8’s nodes.</p>
<pre><code class="has-line-data" data-line-start="54" data-line-end="59" class="language-sh"><span class="hljs-comment"># ansible-galaxy init /etc/ansible/roles/kube_deploy_all --offline</span>
- Role /etc/ansible/roles/kube_deploy_all was created successfully
<span class="hljs-comment"># ansible-galaxy init /etc/ansible/roles/kube_deploy_master --offline</span>
- Role /etc/ansible/roles/kube_deploy_master was created successfully
</code></pre>
<h2 class="code-line" data-line-start=60 data-line-end=61 ><a id="Structure_of_Ansible_roles_60"></a>Structure of Ansible roles:</h2>
<p class="has-line-data" data-line-start="61" data-line-end="62">kube_deploy_all</p>
<pre><code class="has-line-data" data-line-start="63" data-line-end="85" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> roles]<span class="hljs-comment"># tree kube_deploy_all/</span>
kube_deploy_all/
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   ├── configure.yml
│   ├── install.yml
│   ├── main.yml
│   └── service.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
</code></pre>
<p class="has-line-data" data-line-start="85" data-line-end="86">kube_deploy_master</p>
<pre><code class="has-line-data" data-line-start="87" data-line-end="108" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> roles]<span class="hljs-comment"># tree kube_deploy_master/</span>
kube_deploy_master/
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   ├── configure.yml
│   ├── install.yml
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
</code></pre>
<p class="has-line-data" data-line-start="110" data-line-end="111"><strong>Thank you</strong></p>
