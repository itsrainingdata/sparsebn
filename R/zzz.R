#
#  zzz.R
#  sparsebn
#
#  Created by Bryon Aragam (local) on 4/5/16.
#  Copyright (c) 2016 Bryon Aragam. All rights reserved.
#

.onAttach <- function(libname, pkgname){
    ### Only sparsebn needs a package startup message
    packageStartupMessage("NOTE: This package is currently in a development state and may be unstable.\n Please report any bugs at https://github.com/itsrainingdata/sparsebn/issues.")
}
