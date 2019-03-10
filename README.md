### [npm-global](https://github.com/warren-bank/npm-global)

Windows CMD script to globally install `npm` packages into separate directories under a common base path.

#### Why?

* the purpose of global `npm` packages is almost always to install CLI tools
* when they are all installed into a single `node_modules` directory, all of their dependencies get tangled
* in the spirit of "PortableApps" and "AppImage" formats:
  * I'm willing to trade a small amount of space on my hard-drive and allow for some redundancy in common libraries
  * in exchange for standalone self-contained applications

#### Installation:

* save [npm-global.cmd](https://github.com/warren-bank/npm-global/raw/master/bin/npm-global.cmd) to any directory in `PATH`

#### Usage

```bash
rem :: [optional] when unset, the default path is: 'C:\PortableApps'
set base_path=<dirpath>

call npm-global <npm_module>
```

#### Example

* __test script:__
  * [install_nget.bat](https://github.com/warren-bank/npm-global/blob/master/__test__/install_nget.bat)
* __resulting directory structure:__
  ```text
    C:\.workspace\
    ├───.bin\
    │   ├───nget.cmd
    │   └───nget-convert-cookiefile.cmd
    └───node-request-cli\
        └───node_modules\
            ├───.bin\
            │   ├───nget.cmd
            │   └───nget-convert-cookiefile.cmd
            ├───@warren-bank\
            │   ├───node-denodeify\
            │   ├───node-request\
            │   └───node-request-cli\
            ├───ip-regex\
            ├───psl\
            ├───punycode\
            ├───tough-cookie\
            └───tough-cookie-filestore2\
                └───node_modules\
                    └───tough-cookie\
  ```

#### Notes

* `base_path` environment variable can be used to override the default value of the directory base path
  * default value: `C:\PortableApps`
* `.bin` is a subdirectory of `base_path`
  * it should be added to `PATH`
  * it contains `.cmd` scripts that alias (and redirect calls to) the ones installed by `npm`

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
