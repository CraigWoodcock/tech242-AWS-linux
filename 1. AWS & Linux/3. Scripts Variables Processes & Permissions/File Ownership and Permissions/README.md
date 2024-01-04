
# File Ownership and Permissions.

## Why File Ownership is Important.

- **Security** -  File ownership specifies who has can read, edit and execute a file. By controlling ownership, we can prevent unauthorized access or modifications to a file.
- **Accuracy** - File ownership can help to track who was responsible for modifications to a specific file. This can be useful for troubleshooting purposes.
- **Permission Management** - By being able to identify a files owner, we can effectively manage its access levels accordingly.
- **Collaboration** - We can manage the risk of unintended modifications to files when working collaboratively with others within the organization by assigning permissions to specific owners.
- **Accountability** - File ownership records can be useful to identify who made unauthorized changes or had access to sensitive data. encouraging accountability and discouraging misuse.

## Default File Ownership and permissions.

## Default Ownership.
  - The owner of a file or directory is the user that created the file or directory.
  - The owner of a file will usually get full read, write and execute permissions when they create new files or directories.
  - The owner or root are the only ones that can change permissions or ownership
## Why the owner doesn't recieve 'X' Permissions by default.
  - As a safety measure, newly created files are usually created with read, write `-rw-` permissions only.
  - This is to prevent unintentional harm by preventing non executable files, such as harmful scripts from being executed.
## Commands
  - `ls -l <filename>` - gives us the ownership and permsissions.
    - returns a list with permissions like this: `drwxrwxrwx` 
  - `chown <newowner> <filename>` - changes the owner of a file
  - `chown <newowner>:<newgroup> <filename>` - changes the group of a file

## Changing Permissions
- `chmod <abc> <filename` - changes permission of a file using 3 digit number
  - a = user permissions
  - b = group permissions
  - c = everyone else
    - 0 – no access to the file
    - 1 – execute permissions only
    - 2 – write permissions only
    - 3 – write and execute permissions
    - 4 – read permissions only
    - 5 – read and execute permissions
    - 6 – read and write permissions
    - 7 – read, write and execute permissions (full permissions)

 - eg - `chmod 764 myfile.txt` would set full permissions for the user, read and write permissions for the group and read only for everyone else.

- `chmod +r <filename>`, `chmod +w <filename>`, `chmod +x <filename>` - gives read, write or execute to all.
  - `chmod u+r`,`chmod u+w`,`chmod u+x` - change read write or execute for user
  - `chmod g+r`,`chmod g+r`,`chmod g+r` - change read write or execute for group
  - `chmod o+r`,`chmod o+r`,`chmod o+r` - change read write or execute for others




