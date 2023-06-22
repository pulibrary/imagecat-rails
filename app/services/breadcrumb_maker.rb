# sudo code for creating bread crumbs
 class BreacrubMaker
   def create_bread_crumbs(parent_bread_crumb, subguide_card)
     # first call parent_bread_crumb [ "Bible"]
     # second call parent_bread_crumb ["Bible", "Manuscripts"]
     # third call parent_bread_crumb ["Bible", "Manuscripts", "Texts"]
     subguide_card.breadcrub = parent_bread_crumb
     subguide_card.children.each do |child|
        create_bread_crumbs(parent_bread_crumb+subguide_card, subguide_card)
     end
   end

   def create_all_the_crumbs
     GuideCard.all.each do |guide_card|
       # Guide Card: Bible Sub: Manuscripts
       guide_card.children.each do |sub_guide|
         create_bread_crumbs([guide_card],sub_guide)
       end
     end
 end
