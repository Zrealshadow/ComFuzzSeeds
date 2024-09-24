# ComFuzzSeeds: Community Fuzzing Seeds

>This project is about extracting the SQL snippets from Postgres Bug Emailing list as fuzzing seeds to improve the mutation-based-fuzzing process..



### Usage

This process involves a series of scripts to clean the unstructured data. Details of how to use are shown in follows.

During this process, all temporary and intermediate data are stored in `tmp` directory.



**Step 1: Download mbox files**

Download the mbox files from [link](https://www.postgresql.org/list/pgsql-bugs/) into the `data` directory.



**Step 2:  Segment and filter mbox files into mail message** 

One mbox file contains several emails and we only consider the Question email as our target.

execute the `segement.sh` file, which will filter out the message and title of question emails.



**Step 3: Rule-based filter mails**

execute `filter.py` file, which checks whether the content of email contains any Postgres grammar keywords via regrex expression. It will removed about {4000} unused emails.



**Step 4: LLM-based filter mails**

execute `llm_extract.py`, which utilize the large language model to extract the SQL snippets from raw text.



**Step 5: syntax check**

```sh
$ make
$ ./syntax_check.sh
```

execute above commands. the extracted SQL snippets will be checked by Postgres parser to check the syntax.



**Step 6: broken SQL snippet fixing**

```sh
$ python collect_flaw_sqls.py
$ python llm_fixer.py
$ ./filter_syntax_fixed_sqls.sh
```

execute above commands, the flawed SQL snippets will be fixed by large language model. Then, these fixed SQL snippet will be fed into the Postgres parser to check the syntax again. The still broken SQL snippet will be removed. 



**Step 7: Collect cleaned SQL snippet**

```sh
$ python collect_correct_sql.py
$ python collect_fixed_sqls.py
```



