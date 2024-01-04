use dep::aztec::types::address::{AztecAddress, EthereumAddress};
use dep::aztec::types::type_serialization::TypeSerializationInterface;
use dep::aztec::types::type_serialization::field_serialization::FieldSerializationMethods;

struct Product{
    supplier: AztecAddress,
    suppliedProduct: Field,
    }

    global PRODUCT_SERIALIZED_LEN: Field = 2;

    fn deserializeProduct(fields: [Field; PRODUCT_SERIALIZED_LEN]) -> Product {
        Product {
            supplier: AztecAddress::from_field(fields[0]),
            suppliedProduct: fields[1]
    }}

    fn serializeProduct(product: Product) -> [Field; PRODUCT_SERIALIZED_LEN] {
    [
        product.suppliedProduct as Field,
        product.supplier.to_field()
    ]}

    impl Product {
        pub fn serialize(self: Self) -> [Field; PRODUCT_SERIALIZED_LEN] {
        serializeProduct(self)
    }}

    global ProductSerializationMethods = TypeSerializationInterface {
    deserialize: deserializeProduct,
    serialize: serializeProduct,
    };