##load libraries
library(Polychrome)
library(circlize)

mat = read.table("CCLE_stats.csv",sep=",",header=T,stringsAsFactors = F)
df = reshape2::melt(mat)

set.seed(1)
col=createPalette(30, c("#010101", "#ff0000"))

df2 = data.frame(from = paste(df[[1]]),
                 to = paste(df[[2]], df[[3]], sep = "|"),
                 value = df[[4]], stringsAsFactors = FALSE)


set.seed(1)

chordDiagram(x = df2,
             transparency = 0.25,
             directional = 1, direction.type = c("diffHeight", "arrows"),
             link.arr.type = "big.arrow", diffHeight = -0.04, 
             link.sort = TRUE, link.largest.ontop = TRUE, 
             annotationTrack = "grid",
             preAllocateTracks = list(track.height = 0.25),grid.col = col)

circos.track(track.index = 1, bg.border = NA, panel.fun = function(x, y) {
  s = get.cell.meta.data("sector.index")
  xx = get.cell.meta.data("xlim")
  circos.text(x = mean(xx), y = 0.2, 
              labels = s, cex = 0.7, adj = c(0, 0.5),
              facing = "clockwise", niceFacing = TRUE)
  circos.axis(h = "bottom",
              labels.cex = 0.1,
              labels.pos.adjust = FALSE,
              labels.niceFacing = FALSE,minor.ticks = 4,major.tick = T)
})


