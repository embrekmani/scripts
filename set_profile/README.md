# set_profile

script to set list of global environment variables defined in .profile

### usage

in ~/.bashrc add the following lines

`
if [ -f ~/.profile ]; then
    . ~/.profile
fi
`

create a .profile file in the script directory, adding variables like so:

` export HOST_IP="192.168.1.123" `

ensure script has executable permissions

` chmod 755 ./set_profile.sh `

` ./set_profile.sh `