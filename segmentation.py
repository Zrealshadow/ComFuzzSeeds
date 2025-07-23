import argparse
import mailbox
import logging
import os
import json

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
    default="",
    help='Path to mbox file'
)

parser.add_argument(
    '-d', '--dir',
    type=str,
    default="",
    help='Path to directory containing mbox files',
)

parser.add_argument(
    '-b', '--verbose',
    action='store_true',
    help='Whether to print the progress'
)

parser.add_argument(
    '-o', '--output',
    type=str,
    default='',
    help='Path to save the segmented emails'
)

all_mails = 0
parser.add_argument(
    '-p', '--print_title',
    action='store_true',
    help='Whether to print the title of the email'
)


args = parser.parse_args()

verbose = args.verbose
logging.basicConfig(level=logging.DEBUG if verbose else logging.INFO)
LOGGER = logging.getLogger(__name__)


def get_text(mbox_obj):
    LOGGER.debug(f"=============== Overview ===================")
    LOGGER.debug(f"mbox file path : {args.file}")
    LOGGER.debug(f"Total number of mails: {len(mbox_obj)}")

    LOGGER.debug(f"=========== Collect query mails and mail set =============")
    global all_mails 
    all_mails += len(mbox_obj)
    query_mails = []
    # message_id_map = {}
    # reply_map = defaultdict(list) # key: message_id, value: list of reply message

    for msg in mbox_obj:

        subject = msg['Subject']
        if not subject:
            continue

        subject = subject.strip().replace("\n", "")
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

    for msg in query_mails:
        subject = msg['Subject'].strip().replace("\n", " ")
        # extract text
        msg_id = msg['Message-ID']

        if not msg.is_multipart():
            content = msg.get_payload(decode=True).decode(
                'utf-8', errors='ignore')
        else:
            content = ""
            for part in msg.walk():
                content_type = part.get_content_type()
                if content_type != 'text/plain':
                    continue

                content = part.get_payload(decode=True).decode(
                    'utf-8', errors='ignore')
                # try:
                #     content = part.get_payload(decode=True).decode(
                #         'utf-8', errors='ignore')
                # except:
                #     content = ""

                break
            if content == "":
                # this mail has no text content, skip
                continue

        mail_data[msg_id]['subject'] = subject
        mail_data[msg_id]['text'] = content

    LOGGER.debug(f"Total number of query mails with text: {len(mail_data)}")
    return mail_data


if __name__ == '__main__':

    if (args.file == "" and args.dir == "") or (args.file != "" and args.dir != ""):
        LOGGER.error(
            "Please provide either mbox file or directory containing mbox files")
        exit(1)

    mail_data = {}
    default_out_file_name = ""
    if args.file != "":
        LOGGER.info(f"Segmenting mbox file: {args.file}")
        mbox_obj = mailbox.mbox(args.file)
        mail_data = dict(get_text(mbox_obj))
        default_out_file_name = os.path.basename(args.file).split('.')[0]

    if args.dir != "":
        dir_path = args.dir

        if not os.path.isdir(dir_path):
            LOGGER.error(f"Directory {dir_path} does not exist")
            exit(1)

        file_paths = [os.path.join(dir_path, file)
                      for file in os.listdir(dir_path)]
        n = len(file_paths)

        LOGGER.info(
            f"Segmenting mbox files in directory: {dir_path}, total files: {n}")
        for idx, fp in enumerate(file_paths):
            LOGGER.info(f"[{idx} / {n}] Segmenting mbox file: {fp}")
            mbox_obj = mailbox.mbox(fp)
            file_data = get_text(mbox_obj)
            mail_data.update(dict(file_data))

        default_out_file_name = os.path.basename(dir_path)

    if args.print_title:
        for idx, (msg_id, data) in enumerate(mail_data.items()):
            LOGGER.info(f"[{idx}] Subject: {data['subject']}")

    if args.output != "":
        out_file = ""
        if os.path.isdir(dir_path):
            out_file = os.path.join(
                args.output, f"{default_out_file_name}.json")

            with open(out_file, 'w') as f:
                json.dump(mail_data, f)

        else:
            _, extension = os.path.splittext(args.output)

            if extension != ".json":
                LOGGER.error("Please provide output file with .json extension")
                exit(1)
            out_file = args.output
            with open(args.output, 'w') as f:
                json.dump(mail_data, f)

        LOGGER.info(f"Segmented mails are saved at {out_file}")
        LOGGER.info(f"Selected {len(mail_data)} mails out of {all_mails}")