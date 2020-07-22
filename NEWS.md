# sparsebn 0.1.0

## Notes

* Companion JSS paper now published, please see citation() for reference
* Updated CITATION

# sparsebn 0.0.5

## Features

* `estimate.dag` now supports white lists and black lists (#6)
* Cytoscape compatibility now available via the method `openCytoscape` (#4)
* `plotDAG` now includes labels for each subplot by default
* See NEWS files for sparsebnUtils, discretecdAlgorithm, and ccdrAlgorithm for more updates

# sparsebn 0.0.4

## Notes

* Updated CITATION

# sparsebn 0.0.3

## Bug fixes

* Minor bug fixes

# sparsebn 0.0.2

## Features
* Added a `NEWS.md` file to track changes to the package
* Added `plotDAG` to provide convenient default for plotting large graphs
* `estimate.dag` now takes an optional logical argument `adaptive`: If `TRUE`, then an adaptive version of the CD algorithm will be run for discrete data. This argument is ignored for continuous data.
* Vignette updated and re-written

## Bug fixes

* Cytometry data has been fixed to correct some errors in the network structure; now correctly reflects the network learned in Sachs et al. (2005)

# sparsebn 0.0.1

* Initial stable release

