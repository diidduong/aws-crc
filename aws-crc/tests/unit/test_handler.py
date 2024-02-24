import json

import pytest

from visitor_counter import app


@pytest.fixture()
def apigw_event():
    """ Generates API GW Event"""

    return {}


def test_lambda_handler(apigw_event):

    ret = app.lambda_handler(apigw_event, "")
    data = json.loads(ret["body"])

    assert ret["statusCode"] == 200
    assert "message" in ret["body"]
    assert data["message"] == "hello yoo"
