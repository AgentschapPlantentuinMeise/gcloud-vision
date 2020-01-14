from google.cloud.vision_v1 import ImageAnnotatorClient
from google.cloud import vision
from google.oauth2 import service_account
from google.protobuf.json_format import MessageToJson
import os

url_list = os.listdir('imgdir')
credentials = service_account.Credentials. from_service_account_file('bearer_token.json')
client = vision.ImageAnnotatorClient(credentials=credentials)

for i in range(0, len(url_list)):
    uri = 'gs://bucketname/' + url_list[i]
    request = {
        'image': {'source': {'image_uri': uri}},
        'features': [{'type': vision.enums.Feature.Type.TEXT_DETECTION},
            {'type': vision.enums.Feature.Type.DOCUMENT_TEXT_DETECTION},
            {'type': vision.enums.Feature.Type.LABEL_DETECTION},
            {'type': vision.enums.Feature.Type.LOGO_DETECTION},
            {'type': vision.enums.Feature.Type.OBJECT_LOCALIZATION}],
    }
    response = client.annotate_image(request)
    logfile = open('response-dir/%s.json' % url_list[i].replace('.jpg',''),'w')
    logfile.write(MessageToJson(response))
    logfile.close()
