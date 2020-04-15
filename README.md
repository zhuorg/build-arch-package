# Build Arch Linux package Github Action

```yaml
- name: Build Arch Linux package
  uses: FFY00/build-arch-package@master
  with:
    PKGBUILD: path/to/my/PKGBUILD
```

`%COMMIT%` in the PKGBUILD will be replaced by the commit that triggered the action.

### Arguments

Key        | Description                                 | Required | Default Value
---------- | ------------------------------------------- |:--------:| -------------
`PKGBUILD` | PKGBUILD path                               | **Yes**  |
`OUTDIR`   | Output directory to store the built package | No       | `$HOME/arch-packages`

###### You can use environment variable names in the options, they will be resolved.
