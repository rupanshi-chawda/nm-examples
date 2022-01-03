# Remove python3 kernel reference from Launcher tab in JupyterLab

Even if we don't install kernelspec, Jupyter will include the *'default'* kernel, that of the current Python that the notebook is running. This is governed by `c.KernelSpecManager.ensure_native_kernel`. 
</br>

So if you set-
```
c.KernelSpecManager.ensure_native_kernel = False
```
*and* **uninstall** the default kernelspec, it won't show up but all others will.
</br>
Add this line to your configuration file. 
- Open config-s33.yaml 
- Add the above line and update the file
- Roll back the previous version and deploy with edited file using `helm upgrade` cmd. 

</br>

![imageedit_3_8819553273](https://user-images.githubusercontent.com/58527347/147477163-f4755bf2-d45f-4d16-83c9-11606700fb45.jpg)

### Uninstalling / Removing kernel on Jupyter notebook

There two ways, First is either go to the directory where kernels are residing and delete from there. 
- Open Terminal and List the kernel to get path - 
```
$ jupyter kernelspec list 
```
- Navigate to the folder where python3 kernel is located.
- Remove the python3 kernel directory `rm -r python3/`
![image](https://user-images.githubusercontent.com/58527347/147901831-aad3f09b-0d79-4f78-a0fa-b350ab48ebde.png)
- Reload the Page the see the results 
![Screenshot (257)](https://user-images.githubusercontent.com/58527347/147901861-71674727-c18f-44b5-aa0f-9049c934d9bb.png)

---
Another method is to Use this command below - </br>

- Open Terminal in your notebook 
- To List all kernels and grab the name of the kernel you want to remove, also to get the paths of all your kernels.
```
 $ jupyter kernelspec list 
 ```
 ```
 Available kernels:
  kotlin     /opt/conda/share/jupyter/kernels/kotlin
  python3    /opt/conda/share/jupyter/kernels/python3
 ```
 
- Then simply uninstall your unwanted-kernel, you can delete a kernel with jupyter kernelspec remove or jupyter kernelspec uninstall. The latter is an alias for remove. 
```
$ jupyter kernelspec remove <kernel_name>
```
```
Kernel specs to remove:
  python3               /opt/conda/share/jupyter/kernels/python3
Remove 1 kernel specs [y/N]: y
[RemoveKernelSpec] Removed /opt/conda/share/jupyter/kernels/python3
```
> **Refresh** the page and you have removed python3 successfully.

</br>

![Screenshot (257)](https://user-images.githubusercontent.com/58527347/147488364-4b25729a-1c22-432f-bc44-b98b6f8180b9.png)



