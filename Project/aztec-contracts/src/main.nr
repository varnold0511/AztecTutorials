mod products;

contract Trade {
    use dep::aztec::{
        context::{Context},
        hash::{compute_secret_hash},
        state_vars::{public_state::PublicState},
        state_vars::map::Map,
        types::type_serialization::field_serialization::FieldSerializationMethods,
        types::type_serialization::TypeSerializationInterface,
        types::address::{AztecAddress, EthereumAddress},
        selector::compute_selector,
    };

    use crate::products::{PRODUCT_SERIALIZED_LEN, Product, ProductSerializationMethods};

// Storage structure, containing all storage, and specifying what slots they use.
    struct Storage {
        Products: Map<PublicState<Product, PRODUCT_SERIALIZED_LEN>>,
    }

    impl Storage {
        fn init(context: Context) -> Self {
            Storage {
                Products: Map::new(
                    context,
                    3,
                    |context, slot| {
                        PublicState::new(
                            context,
                            slot,
                            ProductSerializationMethods,
                        )
                    },
                ),
            }
         }
    }

    // Constructs the contract.
    #[aztec(private)]
    fn constructor(owner: AztecAddress) {
    }

    //function to store products in Products
    #[aztec(public)]
    fn storeProduct(supplier: msg.sender(), suppliedProduct: Field) -> Products {

        //Start at field 0
        let product_log = storage.Products.at(0);
        let mut product = product_log.read();

        // use the inputs
        product.supplier = supplier as AztecAddress;
        product.suppliedProduct = suppliedProduct as Field;

        //write the inputs into storage
        product_log.write(product);
       }

    // TODO: remove this placeholder once https://github.com/AztecProtocol/aztec-packages/issues/2918 is implemented
    unconstrained fn compute_note_hash_and_nullifier(contract_address: Field, nonce: Field, storage_slot: Field, serialized_note: [Field; 0]) -> [Field; 4] {
        [0, 0, 0, 0]
    }
}

