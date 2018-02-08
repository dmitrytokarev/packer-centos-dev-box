## Packer builds VM images automatically
[Packer](https://www.packer.io) is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel. Packer does not replace configuration management like Chef or Puppet. In fact, when building images, Packer is able to use tools like Chef or Puppet to install software onto the image.

A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, etc.


## Requirements:
[Install packer](https://www.packer.io/docs/installation.html)

To build VirtualBox images install [VirtualBox](https://www.virtualbox.org/)

To build VMware images host must be running:
 - [VMware Fusion](https://www.vmware.com/products/fusion/overview.html) for OS X,
 - [VMware Workstation](https://www.vmware.com/products/workstation/overview.html) for Linux and Windows,
 - [VMware Player](https://www.vmware.com/products/player/) on Linux.
 - Packer can also build machines directly on [VMware vSphere Hypervisor](https://www.vmware.com/products/vsphere-hypervisor/)
using SSH as opposed to the vSphere API. Good post on how it's done: https://nickcharlton.net/posts/using-packer-esxi-6.html

## Templates
TODO: describe Packer template structure, user variables, var-files, user must provide their own iso_url

https://www.packer.io/docs/templates/user-variables.html

https://www.packer.io/docs/templates/index.html#template-structure

https://hodgkins.io/best-practices-with-packer-and-windows  --- Packer best practices

## Validate
Validate Packer json template:

    packer validate --var-file=centos_7.4_desktop.json centos_base.json

## Build

NOTE: before building update iso path in the Packer template files (centos_6_desktop.json, centos_6_server.json).

Build VirtualBox image only ([docs](https://www.packer.io/docs/builders/virtualbox-iso.html)):

    packer build --only=virtualbox --var-file=centos_7.3_desktop.json centos.json

Build VMware image only ([docs](https://www.packer.io/docs/builders/vmware-iso.html)):

    packer build --only=vmware --var-file=centos_7.3_desktop.json centos.json


Build all image types (runs in parallel):

    packer build --var-file=centos_7.3_desktop.json centos.json

Use -force option to overwrite existing artifacts:

    packer build -force --var-file=centos_7.3_desktop.json centos.json
    
[More build options](https://www.packer.io/docs/command-line/build.html)

## Docs
[Packer docs](https://www.packer.io/docs/) are short and to the point! Please read them first before contributing.

## Examples
https://blog.codeship.com/packer-vagrant-tutorial/
https://github.com/geerlingguy/packer-centos-7/blob/master/Vagrantfile
https://github.com/boxcutter/centos
https://github.com/hfm/packer-centos-7
https://www.packer.io/docs/post-processors/vagrant.html
