// This class represents offline assets.
// While the offline assets are going to be any types of assets like ERC20, ERC721, etc, 
// we are currently focusing on ERC20 assets

class OfflineAsset{
  String id;
  String name;
  String symbol;
  String value;
  String nullifier;
  String commitment;
  String assetType;
  String originTree;
  DateTime createdAt;

  OfflineAsset({
    required this.id,
    required this.name,
    required this.symbol,
    required this.value,
    required this.nullifier,
    required this.commitment,
    required this.assetType,
    required this.originTree,
    required this.createdAt,
  });
  
}