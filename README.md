<h1 class="code-line" data-line-start=0 data-line-end=1 ><a id="Objective_Kubernetes_cluster_setup_using_Ansible_0"></a>Objective: Kubernetes cluster setup using Ansible</h1>
<p class="has-line-data" data-line-start="2" data-line-end="3"><a href="https://travis-ci.org/joemccann/dillinger"><img src="https://travis-ci.org/joemccann/dillinger.svg?branch=master" alt="Build Status"></a></p>
<h2 class="code-line" data-line-start=3 data-line-end=4 ><a id="Description_3"></a>Description:</h2>
<p class="has-line-data" data-line-start="4" data-line-end="5">I used an EC2 instance (CentOS) and installed Ansible on it, also used CentOS for the Kube servers. Used passwordless authentication between the Ansible server and the K8’s servers. I have created a script to avoid configuring the Ansible hosts manually and it will also verify the connection to the Kube servers are faultless. The script will ask for some details such as the public IP of K8’s Master, no. of K8’s Nodes for the cluster, and the public IPs of worker nodes. After that, I have initialized the Ansible roles and to set up the Kube cluster proper YAML files are placed under the respective roles. The YAML file consists of installing services and dependencies, also to satisfy the Kubernetes requirements I have used “Flannel” as an Overlay Network. The interesting fact is that I’m not touching the K8’s master and its nodes for configuration. The execution of the playbook will results in the K8’s cluster formation within 10 mins (PS: If you have a good internet connection).</p>
<h2 class="code-line" data-line-start=7 data-line-end=8 ><a id="Prerequisite_7"></a>Prerequisite:</h2>
<ul>
<li class="has-line-data" data-line-start="9" data-line-end="10">A server with Ansible installed.</li>
<li class="has-line-data" data-line-start="10" data-line-end="11">A server for K8’s Master and ‘n’ no.of nodes (You can specify any no.of K8’s nodes)</li>
<li class="has-line-data" data-line-start="11" data-line-end="13">Public IP address of K8’s Master and ‘n’ nodes</li>
</ul>
<h2 class="code-line" data-line-start=13 data-line-end=14 ><a id="Steps_13"></a>Steps:</h2>
<ul>
<li class="has-line-data" data-line-start="15" data-line-end="16">Step 1: Installed Ansible on a CentOS server.</li>
<li class="has-line-data" data-line-start="16" data-line-end="17">Step 2: Made passwordless authentication with the Ansible server and the K8’s servers.</li>
<li class="has-line-data" data-line-start="17" data-line-end="18">Step 3: Run the script <strong><a href="http://configure.sh">configure.sh</a></strong> which is present under the root directory.</li>
<li class="has-line-data" data-line-start="18" data-line-end="22">Step 4: The script will ask for the details such as:
<ol>
<li class="has-line-data" data-line-start="19" data-line-end="20">The public IP address of K8’s master</li>
<li class="has-line-data" data-line-start="20" data-line-end="21">No.of Kube nodes which you want to use for the cluster.</li>
<li class="has-line-data" data-line-start="21" data-line-end="22">The public IP address of “n” no. of nodes</li>
</ol>
</li>
<li class="has-line-data" data-line-start="22" data-line-end="23">Step 5: If the connections are perfect the script will show the ping result to the K8’s master and its nodes as an output.</li>
<li class="has-line-data" data-line-start="23" data-line-end="24">Step 6: Initialized the Ansible roles.</li>
<li class="has-line-data" data-line-start="24" data-line-end="26">Step 7: Run the setup.yml file with the Ansible playbook command.</li>
</ul>
<h2 class="code-line" data-line-start=26 data-line-end=27 ><a id="Installation_26"></a>Installation:</h2>
<p class="has-line-data" data-line-start="28" data-line-end="29">Installing Ansible on CentOS server:</p>
<pre><code class="has-line-data" data-line-start="30" data-line-end="33" class="language-sh">$ sudo yum update -y
$ sudo yum install ansible -y
</code></pre>
<p class="has-line-data" data-line-start="33" data-line-end="35">This would successfully install the Ansible.<br>
Also recommended to do an update after the installation of ansible</p>
<h2 class="code-line" data-line-start=36 data-line-end=37 ><a id="File_Locations_36"></a>File Locations:</h2>
<p class="has-line-data" data-line-start="38" data-line-end="39">The Shell Script and Yaml file are present under the directory named “cluster”.</p>
<pre><code class="has-line-data" data-line-start="40" data-line-end="47" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> cluster]<span class="hljs-comment"># pwd</span>
/root/cluster
[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> cluster]<span class="hljs-comment"># ll</span>
total <span class="hljs-number">8</span>
-rwx------. <span class="hljs-number">1</span> root root <span class="hljs-number">1143</span> Jun <span class="hljs-number">11</span> <span class="hljs-number">11</span>:<span class="hljs-number">02</span> configure.sh
-rw-r--r--. <span class="hljs-number">1</span> root root  <span class="hljs-number">109</span> Jun <span class="hljs-number">11</span> <span class="hljs-number">06</span>:<span class="hljs-number">30</span> setup.yml
</code></pre>
<h3 class="code-line" data-line-start=48 data-line-end=49 ><a id="Output_of_the_Shell_script_48"></a><strong><em>Output of the Shell script:</em></strong></h3>
<p class="has-line-data" data-line-start="50" data-line-end="51"><img src="Screenshots/Shell_Script_Output.png" alt=""></p>
<h2 class="code-line" data-line-start=52 data-line-end=53 ><a id="Initializing_Ansible_roles_52"></a>Initializing Ansible roles:</h2>
<p class="has-line-data" data-line-start="54" data-line-end="56">Ansible-galaxy is the command to be used to re-define the Ansible roles<br>
I have initialized two roles, one for K8’s Master and one for K8’s nodes.</p>
<pre><code class="has-line-data" data-line-start="57" data-line-end="62" class="language-sh"><span class="hljs-comment"># ansible-galaxy init /etc/ansible/roles/kube_deploy_all --offline</span>
- Role /etc/ansible/roles/kube_deploy_all was created successfully
<span class="hljs-comment"># ansible-galaxy init /etc/ansible/roles/kube_deploy_master --offline</span>
- Role /etc/ansible/roles/kube_deploy_master was created successfully
</code></pre>
<h2 class="code-line" data-line-start=63 data-line-end=64 ><a id="Ansible_roles_63"></a>Ansible roles:</h2>
<h5 class="code-line" data-line-start=64 data-line-end=65 ><a id="Role_1_kube_deploy_all_64"></a>Role 1: kube_deploy_all</h5>
<ul>
<li class="has-line-data" data-line-start="65" data-line-end="66">The configure.yml file consists of disabling SELinux, disabling swap, adding Kubernetes yum repositories, etc on all the K8’s servers.</li>
<li class="has-line-data" data-line-start="66" data-line-end="67">The install.yml file consists of installing docker service, kubectl, kubeadm, etc on all the K8’s servers.</li>
<li class="has-line-data" data-line-start="67" data-line-end="68">The service.yml file consists of starting the docker and kubelet service.</li>
</ul>
<pre><code class="has-line-data" data-line-start="69" data-line-end="91" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> roles]<span class="hljs-comment"># tree kube_deploy_all/</span>
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
<h5 class="code-line" data-line-start=92 data-line-end=93 ><a id="Role_2_kube_deploy_master_92"></a>Role 2: kube_deploy_master</h5>
<ul>
<li class="has-line-data" data-line-start="93" data-line-end="94">The configure.yml file consists of initializing the cluster, copying admin.conf contents to the user’s Kube configuration, installing the Pod overlay network (Flannel) on K8’s master.</li>
<li class="has-line-data" data-line-start="94" data-line-end="96">The install.yml file consists of installing the kubectl service on K8’s master.</li>
</ul>
<pre><code class="has-line-data" data-line-start="97" data-line-end="118" class="language-sh">[root@ip-<span class="hljs-number">172</span>-<span class="hljs-number">31</span>-<span class="hljs-number">86</span>-<span class="hljs-number">154</span> roles]<span class="hljs-comment"># tree kube_deploy_master/</span>
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
<h2 class="code-line" data-line-start=118 data-line-end=119 ><a id="Ports_to_be_allowed_on_the_Kube_servers_118"></a>Ports to be allowed on the Kube servers:</h2>
<table class="table table-striped table-bordered">
<thead>
<tr>
<th style="text-align:left">Ports</th>
<th style="text-align:left">Description</th>
<th style="text-align:left">Server</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left">6443/tcp</td>
<td style="text-align:left">Kubernetes API port</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">2379-2380/tcp</td>
<td style="text-align:left">etcd server client API</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">10250/tcp</td>
<td style="text-align:left">API which allows full node access</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">10251/tcp</td>
<td style="text-align:left">kube-scheduler</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">10252/tcp</td>
<td style="text-align:left">kube-controller-manager</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">10255/tcp</td>
<td style="text-align:left">HTTP read-only port</td>
<td style="text-align:left">All k8s servers</td>
</tr>
<tr>
<td style="text-align:left">30000-32767/tcp</td>
<td style="text-align:left">NodePort Services</td>
<td style="text-align:left">Only on worker nodes</td>
</tr>
<tr>
<td style="text-align:left">6783-6784/tcp</td>
<td style="text-align:left">CNI ports</td>
<td style="text-align:left">Only on worker nodes</td>
</tr>
</tbody>
</table>
<h2 class="code-line" data-line-start=130 data-line-end=131 ><a id="Ansible_playbook_130"></a>Ansible playbook</h2>
<p class="has-line-data" data-line-start="132" data-line-end="133">Run the ansible playbook named “setup.yml”</p>
<pre><code class="has-line-data" data-line-start="135" data-line-end="137" class="language-sh"><span class="hljs-comment"># ansible-playbook setup.yml</span>
</code></pre>
<p class="has-line-data" data-line-start="137" data-line-end="138">By running this file will install all the services, dependencies, Overlay Network, etc for the Kubernetes cluster setup. Upon completion of all the above steps, the Kubernetes cluster should be up and running. We can login to the master or worker nodes. The result of the successfull installation of the Kubernetes are stored on a file named “cluster_initialized.txt” on the root directory. On the same file there consists of the joining token for the worker nodes to join with the Kubernetes master. Executing the token on the worker nodes will finish the job.</p>
<h2 class="code-line" data-line-start=139 data-line-end=140 ><a id="Outputs_139"></a>Outputs:</h2>
<h4 class="code-line" data-line-start=141 data-line-end=142 ><a id="Token_for_joining_the_worker_nodes_141"></a><strong><em>Token for joining the worker nodes</em></strong></h4>
<p class="has-line-data" data-line-start="143" data-line-end="144"><img src="Screenshots/Successful_Output.png" alt=""></p>
<h4 class="code-line" data-line-start=145 data-line-end=146 ><a id="All_the_pods_are_up_and_running_145"></a><strong><em>All the pods are up and running</em></strong></h4>
<p class="has-line-data" data-line-start="147" data-line-end="148"><img src="Screenshots/K8s_cluster_Output.png" alt=""></p>
<h4 class="code-line" data-line-start=149 data-line-end=150 ><a id="Details_of_created_Overlay_Network_Flannel_149"></a><strong><em>Details of created Overlay Network (Flannel)</em></strong></h4>
<p class="has-line-data" data-line-start="151" data-line-end="152"><img src="Screenshots/Flannel.png" alt=""></p>
<h2 class="code-line" data-line-start=154 data-line-end=155 ><a id="Conclusion_154"></a>Conclusion:</h2>
<p class="has-line-data" data-line-start="155" data-line-end="156">As we can see the master and worker nodes are in ready status. This concludes that kubernetes has been installed successfully and also successfully joined two worker nodes. Now its possible to create pods and services on this Kube Cluster.</p>
<p class="has-line-data" data-line-start="157" data-line-end="158"><strong>Thank you</strong></p>
