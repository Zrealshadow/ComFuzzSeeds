import argparse
import mailbox
import logging

from collections import defaultdict
from tqdm import tqdm

parser = argparse.ArgumentParser(
    description="To segment mbox file into individual mails including text and subject"
)

parser.add_argument(
    '-v', '--version',
    action='version',
    version='%(prog)s 1.0'
)


parser.add_argument(
    '-f', '--file',
    type=str,
    required=True,
    help='Path to mbox file'
)

parser.add_argument(
    '-b', '--verbose',
    action='store_true',
    help='Whether to print the progress'
)

args = parser.parse_args()

verbose = args.verbose
logging.basicConfig(level=logging.DEBUG if verbose else logging.INFO)
LOGGER = logging.getLogger(__name__)

# segment
mbox_obj = mailbox.mbox(args.file)

LOGGER.debug(f"=============== Overview ===================")
LOGGER.debug(f"mbox file path : {args.file}")
LOGGER.debug(f"Total number of mails: {len(mbox_obj)}")


LOGGER.debug(f"=========== Collect query mails and mail set =============")


query_mails = []
# message_id_map = {}
# reply_map = defaultdict(list) # key: message_id, value: list of reply message

for msg in mbox_obj:

    subject = msg['Subject'].strip().replace("\n", "")
    """
    We filter the mails with subject with prefix "RE:" or "Re:"
    """
    # message_id = msg.get('Message-ID')
    # in_reply_to = msg.get('In-Reply-To')
    # references = msg.get('References')

    # if message_id:
    #     message_id_map[message_id] = msg

    if subject.startswith("Re:") \
            or subject.startswith("RE:"):
        continue

    query_mails.append(msg)


LOGGER.debug(
    f"Total number of query mails: {len(query_mails)} / {len(mbox_obj)}")


mail_data = defaultdict(dict)

for msg in tqdm(query_mails, desc="Priocessing emails"):
    subject = msg['Subject'].strip().replace("\n", " ")
    # extract text
    msg_id = msg['Message-ID']

    if not msg.is_multipart():
        content = msg.get_payload(decode=True)
    else:
        content = ""
        for part in msg.walk():
            content_type = part.get_content_type()
            if content_type != 'text/plain':
                continue
            content = part.get_payload(decode=True).decode('utf-8')
            break
        if content == "":
            # this mail has no text content, skip
            continue

    mail_data[msg_id]['subject'] = subject
    mail_data[msg_id]['text'] = content


LOGGER.debug(f"Total number of query mails with text: {len(mail_data)}")


LOGGER.debug(f"=========== Save segmented mails =============")

