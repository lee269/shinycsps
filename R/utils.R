
ou_data <- function(data, hierarchy, hierarchy_meta, oucode = "DEFRA0000"){
  ou <- hierarchy %>% 
    dplyr::filter(OUcode == oucode) %>% 
    dplyr::left_join(hierarchy_meta) %>% 
    dplyr::left_join(data)
  return(ou)
  
}