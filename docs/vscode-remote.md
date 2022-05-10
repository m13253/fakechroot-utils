1. Install “wget” and “tar” in your chroot environment.

2. In your local system, find `~/.ssh/config`.

   (For Windows, it is `%USERPROFILE%\.ssh\config`.)

3. Add the following lines:

   ```etc
   Host <my_host_alias>
       HostName <original_ssh_host_name>
       RequestTTY force
       RemoteCommand exec ~/fakechroot.sh /bin/bash
   ```

   Change `<my_host_alias>` to whatever name you want, and `<original_ssh_host_name>` to the original SSH host name you want to connect to.

4. In Visual Studio Code, change the following settings:

   * Remote.SSH: Enable Remote Command: Yes
   * Remote.SSH: Use Local Server: Yes

5. In Visual Studio Code, when you want to connect to the remote host, choose the host alias you created in step 3.
