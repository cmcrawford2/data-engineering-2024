if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data.columns = (data.columns
                    .str.replace('ID', '_ID')
                    .str.replace('Location', '_Location')
                    .str.lower())

    print(f"Rows with passenger count = 0: {data['passenger_count'].isin([0]).sum()}")

    data = data[data['passenger_count'] > 0]

    print(f"Rows with trip distance = 0: {data['trip_distance'].isin([0.0]).sum()}")

    return data[data['trip_distance'] > 0.0]
    
@test
def test_output(output, *args):
    assert "vendor_id" in df.columns, "Column name 'VendorID' not found, expected 'vendor_id'"

@test
def test_output(output, *args):
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with 0 passengers'

@test
def test_output(output, *args):
    assert output['trip_distance'].isin([0.0]).sum() == 0, 'There are trips with 0 distance'

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
