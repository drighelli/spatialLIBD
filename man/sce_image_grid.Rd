% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sce_image_grid.R
\name{sce_image_grid}
\alias{sce_image_grid}
\title{Sample spatial cluster visualization grid}
\usage{
sce_image_grid(
  sce,
  clustervar,
  pdf_file,
  sort_clust = TRUE,
  colors = NULL,
  return_plots = FALSE,
  spatial = TRUE,
  ...
)
}
\arguments{
\item{sce}{Defaults to the output of
\code{fetch_data(type = 'sce')}. This is a
\linkS4class{SingleCellExperiment}
object with the spot-level Visium data and information required for
visualizing the histology. See \code{\link[=fetch_data]{fetch_data()}} for more details.}

\item{clustervar}{A \code{character(1)} with the name of the \code{colData(sce)}
column that has the cluster values.}

\item{pdf_file}{A \code{character(1)} specifying the path for the resulting PDF.}

\item{sort_clust}{A \code{logical(1)} indicating whether you want to sort
the clusters by frequency using \code{\link[=sort_clusters]{sort_clusters()}}.}

\item{colors}{A vector of colors to use for visualizing the clusters
from \code{clustervar}. If the vector has names, then those should match the
values of \code{clustervar}.}

\item{return_plots}{A \code{logical(1)} indicating whether to print the plots
to a PDF or to return the list of plots that you can then print using
\link[cowplot:plot_grid]{plot_grid}.}

\item{spatial}{A \code{logical(1)} indicating whether to include the histology
layer from \code{\link[=geom_spatial]{geom_spatial()}}. If you plan to use
\link[plotly:ggplotly]{ggplotly()} then it's best to set this to \code{FALSE}.}

\item{...}{Passed to \link[base:paste]{paste0()} for making the title of the
plot following the \code{sampleid}.}
}
\value{
A list of \link[ggplot2:ggplot]{ggplot2} objects.
}
\description{
This function visualizes the clusters for a set of samples at the spot-level
using (by default) the histology information on the background. To visualize
gene-level (or any continuous variable) use \code{\link[=sce_image_grid_gene]{sce_image_grid_gene()}}.
}
\details{
This function prepares the data and then loops through
\code{\link[=sce_image_clus]{sce_image_clus()}} for computing the list of \link[ggplot2:ggplot]{ggplot2}
objects.
}
\examples{

if (enough_ram()) {
    ## Obtain the necessary data
    if (!exists("sce")) sce <- fetch_data("sce")

    ## Subset to two samples of interest
    sce_sub <- sce[, sce$sample_name \%in\% c("151673", "151674")]

    ## Obtain the plot list
    p_list <-
        sce_image_grid(
            sce_sub,
            "layer_guess_reordered",
            spatial = FALSE,
            return_plots = TRUE,
            sort_clust = FALSE,
            colors = libd_layer_colors
        )
        
     ## Or you can do this with a VisiumEsperiment object
     ve_sub <- sce_to_ve(sce_sub)
     p_list <-
        sce_image_grid(
            ve_sub,
            "layer_guess_reordered",
            spatial = FALSE,
            return_plots = TRUE,
            sort_clust = FALSE,
            colors = libd_layer_colors
        )
     
    ## Clean up
    rm(sce_sub)

    ## Visualize the spatial adjacent replicates for position = 0 micro meters
    ## for subject 3
    cowplot::plot_grid(plotlist = p_list, ncol = 2)
}
}
\seealso{
Other Spatial cluster visualization functions: 
\code{\link{sce_image_clus_p}()},
\code{\link{sce_image_clus}()}
}
\concept{Spatial cluster visualization functions}
