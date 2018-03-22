class Herbs

  def self.names
    ["Allbright", "Aloe", "Altar's Blessing", "Anansi", "Apiphenalm", "Apothecary's Scythe", "Artemisia",
     "Asafoetida", "Asane", "Ashoka", "Azure Tristeria", "Banto", "Bay Tree", "Bee Balm", "Beetle Leaf",
     "Beggar's Button", "Bhilawa", "Bilimbi", "Bitter Florian", "Black Pepper Plant", "Blessed Mariae",
     "Bleubillae", "Blood Balm", "Blood Blossom", "Blood Root", "Blooded Harebell", "Bloodwort", "Blue Damia",
     "Blue Tarafern", "Blueberry Tea Tree", "Bluebottle Clover", "Blushing Blossom", "Brassy Caltrops",
     "Brown Muskerro", "Buckler-Leaf", "Bull´s Blood", "Burnt Tarragon", "Butterfly Damia", "Butterroot",
     "Calabash", "Camelmint", "Caraway", "Cardamom", "Cassia", "Chaffa", "Chatinabrae", "Chives", "Chukkah",
     "Cicada Bean", "Cinnamon", "Cinquefoil", "Cirallis", "Clingroot", "Common Basil", "Common Rosemary",
     "Common Sage", "Corsacia", "Covage", "Crampbark", "Cranesbill", "Creeping Black Nightshade", "Creeping Thyme",
     "Crimson Clover", "Crimson Lettuce", "Crimson Nightshade", "Crimson Pipeweed", "Crimson Windleaf",
     "Crumpled Leaf Basil", "Curly Sage", "Cyan Cressida", "Daggerleaf", "Dalchini", "Dameshood", "Dank Mullien",
     "Dark Ochoa", "Dark Radish", "Deadly Catsclaw", "Deadwood Tree", "Death's Piping", "Dewplant", "Digweed",
     "Discorea", "Drapeau D'or", "Dusty Blue Sage", "Dwarf Hogweed", "Dwarf Wild Lettuce", "Earth Apple", "Elegia",
     "Enchanter's Plant", "Finlow", "Fire Allspice", "Fire Lily", "Fivesleaf", "Flaming Skirret", "Flander's Blossom",
     "Fleabane", "Fool's Agar", "Fumitory", "Garcinia", "Garlic Chives", "Ginger Root", "Ginger Tarragon",
     "Ginseng Root", "Glechoma", "Gnemnon", "Gokhru", "Golden Dubloons", "Golden Gladalia", "Golden Sellia",
     "Golden Sun", "Golden Sweetgrass", "Golden Thyme", "Gynura", "Harebell", "Harrow", "Hazlewort", "Headache Tree",
     "Heartsease", "Hogweed", "Homesteader Palm", "Honey Mint", "Houseleek", "Hyssop", "Ice Blossom", "Ice Mint",
     "Ilex", "Indigo Damia", "Ipomoea", "Jagged Dewcup", "Jaivanti", "Jaiyanti", "Joy of the Mountain", "Jugwort",
     "Katako Root", "Khokali", "King's Coin", "Lamae", "Larkspur", "Lavender Navarre", "Lavender Scented Thyme",
     "Lemon Basil", "Lemon Grass", "Lemondrop", "Lilia", "Liquorice", "Lungclot", "Lythrum", "Mahonia", "Malice Weed",
     "Mandrake Root", "Maragosa", "Mariae", "Meadowsweet", "Medicago", "Mindanao", "Miniature Bamboo",
     "Miniature Lamae", "Mirabellis Fern", "Moon Aloe", "Morpha", "Motherwort", "Mountain Mint", "Myristica",
     "Myrrh", "Naranga", "Nubian Liquorice", "Octec's Grace", "Opal Harebell", "Orange Niali", "Orange SweetGrass",
     "Orris", "Pale Dhamasa", "Pale Ochoa", "Pale Russet", "Pale Skirret", "Panoe", "Paradise Lily", "Patchouli",
     "Peppermint", "Pippali", "Pitcher Plant", "Primula", "Prisniparni", "Pulmonaria Opal", "Purple Tintiri",
     "Quamash", "Red Pepper Plant", "Revivia", "Rhubarb", "Royal Rosemary", "Rubia", "Rubydora", "Sacred Palm",
     "Sagar Ghota", "Sandalwood", "Sandy Dustweed", "Satsatchi", "Scaley Hardwood", "Schisandra", "Shrub Sage",
     "Shrubby Basil", "Shyama", "Shyamalata", "Sickly Root", "Silvertongue Damia", "Skirret", "Sky Gladalia",
     "Soapwort", "Sorrel", "Spinach", "Spinnea", "Squill", "Steel Bladegrass", "Stickler Hedge", "Strawberry Tea",
     "Strychnos", "Sugar Cane", "Sweet Groundmaple", "Sweetflower", "Sweetgrass", "Sweetsop", "Tagetese",
     "Tamarask", "Tangerine Dream", "Thunder Plant", "Thyme", "Tiny Clover", "Trilobe", "Tristeria",
     "True Tarragon", "Tsangto", "Tsatso", "Turtle's Shell", "Umber Basil", "Upright Ochoa", "Vanilla Tea Tree",
     "Verdant Squill", "Verdant Two-Lobe", "Wasabi", "Weeping Patala", "White Pepper Plant", "Whitebelly",
     "Wild Garlic", "Wild Onion", "Wild Lettuce", "Wild Yam", "Wood Sage", "Xanat", "Xanosi", "Yava",
     "Yellow Gentian", "Yellow Tristeria", "Yigory", "Zanthoxylum"]
  end

  # This method will return the correct case herb name for a valid input
  # It will return nil when no match is found
  def self.correct_case(herb)
    Herbs.names.each do |item|
      if herb.downcase == item.downcase
        return item
      end
    end
    nil
  end
end
