def test_home(client):
    response = client.get('/')
    assert response.status_code == 200


def test_debug(client):
    response = client.get('/debug/')
    assert response.status_code == 200
