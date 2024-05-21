
<a name="readme-top"></a>
<br />
<div align="center">

  <h3 align="center">jal-motd</h3>

  <p align="center">
    A Dynamic and highly  customizable MOTD, heavily based off of <a href = "https://github.com/ar51an/raspberrypi-motd">raspberrypi-motd by ar51an.</a>
    <br />
    <br />
  </p>
</div>

Going into my continuation of this, I wanted to include things that added ease of installation, and further configuration. It is my first time really trying to make a servicable github repo as well. Please feel free to leave feedback.

I'd also like to see what else people can add to this - perhaps more metrics? Contribution could be easy, and you can read up more on motd [here](https://wiki.debian.org/motd).

#### What it looks like (with default colors)

![default output](https://i.ibb.co/BjQCL4F/demo.png)

## Install

**(Goal 1: Ease of installation)** Installation is simple using install.sh and uninstall.sh. You can also manually install the files. Documentation coming soon, or ar51an covers it in his repo [here](https://github.com/ar51an/raspberrypi-motd?tab=readme-ov-file#steps).

**Install / Deployment:**

```sh
sudo wget -O install-motd.sh "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/install.sh"
sudo chmod +x install-motd.sh
sudo ./install-motd.sh
```

**Uninstall:**

```sh
sudo wget -O uninstall-motd.sh "https://raw.githubusercontent.com/justinlevinedotme/jal-motd/main/uninstall.sh"
sudo chmod +x uninstall-motd.sh
sudo ./uninstall-motd.sh
```

## Customization

(**Goal 2: Customizable)** Customization of your MOTD is also pretty straightforward. There are 3 files in which customizations are applied. *Warning! Do not change anything in `/etc/update-motd.d/20-update` as this will surely break the timer installed.*

- `/etc/update-motd.d/10-welcome`
![10-welcome](https://i.ibb.co/qs3Fcv5/10-welcome-scr.png)
- `/etc/update-motd.d/15-filesystem`
![15-filesystem](https://i.ibb.co/wKJTfc4/20-update-scr.png)
- `/etc/update-motd-static.d/20-update`
![20-update](https://i.ibb.co/6nDFMgp/20-update-scr.png)

The currently supported customization is primarily coloring and text styling, although I would like to add more in the future. See below for a list of things to customize.

#### 10-welcome

```sh
#Color Configs (Defaults shown)
#deviceColor = The header, what it calls your device.
deviceColorFg=0    # Black text
deviceColorBg=7    # White background
deviceBold=false    # Bold text

#greetingsColor = the date shown, etc.
greetingsColorFg=7 # White text
greetingsColorBg=0 # Default background
greetingsBold=false

#userColor = what it calls you!
userColorFg=0      # Black text
userColorBg=87     # #60FDFF background
userBold=true

#codenameColor = "bookworm"
codenameColorFg=8  # Dark gray text
codenameColorBg=0  # Default background
codenameBold=false
```

#### 15-filesystem

```sh
#Color Configs (defaults shown)
#statsLabelColor = the actual stats of your machine.
statsLabelColorFg=7  # White
statsLabelColorBg=0  # Default background
statsLabelBold=false

#bulletColor = the final "." before showing the stats
bulletColorFg=8  # Dark gray
bulletColorBg=0  # Default background
bulletBold=false

#infoColor = labels like "LAST, or IP"
infoColorFg=87  # #60FDFF
infoColorBg=0  # Default background
infoBold=true

#dimInfoColor = sub labels like * 05-20-24 11:50
dimInfoColorFg=8  # Dim version of #60FDFF
dimInfoColorBg=0  # Default background
dimInfoBold=false
```

#### 20-update

```sh
#Color Configs (Defaults shown)
#msgColor = everything besides the update count.
msgColorFg=7 #White Text
msgColorBg=0 #No BG         
msgBold=false

#countZeroColor = the color of the number of packages if zero updates needed.
countZeroColorFg=16   # Black text
countZeroColorBg=242  # Gray background
countZeroBold=false

#countNonZeroColor = the color of the number of packages if updates are needed.
countNonZeroColorFg=16 # Black text
countNonZeroColorBg=71 # Green background
countNonZeroBold=false
```

## Adding to your MOTD

Adding to your MOTD is also fairly straightforward.

The `/etc/update-motd.d` folder loads the files in order according to the two numbers ahead of their name. For example, in the case of our folder, the files appear on login as such:

```
1. 10-welcome
2. 15-filesystem
3. 20-update (intentionally blank)
```

Keeping that in mind, if you were to add a file with 11 before the same, for example: `11-foo`, the file would then load after `10-welcome` but before `15-filesystem`. Feel free to make some cool stuff and add to our repo by contributing. More on that next.

## Contributing

Contributions are always welcome!

For example, I don't know how on earth to write a contributing.md, or what is even a good way to go about it. I'd really love the ability to add some of your code here too.

## Acknowledgements

- [Readme Generator](readme.so)
- [raspberripi-motd](https://github.com/ar51an/raspberrypi-motd)
- [Best-README-template](https://github.com/othneildrew/Best-README-Template)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/justinlevinedotme/jal-motd.svg?style=for-the-badge
[contributors-url]: https://github.com/justinlevinedotme/jal-motd/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/justinlevinedotme/jal-motd.svg?style=for-the-badge
[forks-url]: https://github.com/justinlevinedotme/jal-motd/network/members
[stars-shield]: https://img.shields.io/github/stars/justinlevinedotme/jal-motd.svg?style=for-the-badge
[stars-url]: https://github.com/justinlevinedotme/jal-motd/stargazers
[license-shield]: https://img.shields.io/github/license/justinlevinedotme/jal-motd.svg?style=for-the-badge
[license-url]: https://github.com/justinlevinedotme/jal-motd/blob/master/LICENSE.txt

