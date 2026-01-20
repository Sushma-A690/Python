Big Data – Hadoop & Spark 
What is Big Data?
Big Data deals with very large files (often > 1 TB).
Processing requires high computation.
Data is processed using parallel computation across multiple machines.

**Hadoop Architecture**
Core Components
HDFS (Hadoop Distributed File System) – Storage
MapReduce – Processing
YARN – Resource management

HDFS (Storage Layer)
Large files are broken into blocks:Default block size: 128 MB / 256 MB
Blocks are distributed across multiple DataNodes.
Enables parallel read and write.
HDFS Nodes
NameNode (Master Node):Stores metadata (file name, block locations),Knows where each block is stored
DataNode (Worker Node):Stores actual data blocks
Performs read/write operations
Data Backup in HDFS:HDFS maintains replicas of blocks (default replication factor = 3).
Ensures fault tolerance.
Replication and recovery can take significant time for large data.

**MapReduce (Processing Layer)**
Map Phase:Processes data in parallel
Example: counts each word/record
Reduce Phase:Aggregates and summarizes results
Produces a single final output
Limitation:Every step reads from disk and writes back to disk, Results in slower performance

**Spark Architecture**
Why Spark?
Designed for high-performance processing Avoids repeated disk I/O
Ideal for iterative and real-time workloads

Key Concepts in Spark
In-Memory Processing: Data is read once from disk Stored in RAM
Intermediate results stay in memory Only final output is written to disk

**Spark Components**
Driver Program
Controls the execution of the Spark application
Creates SparkContext
Coordinates tasks

RDD (Resilient Distributed Dataset)
Distributed collection of data
Stored in memory
Fault-tolerant
Immutable

Cluster Management
Manages resources such as:
Number of executors,CPU cores, Memory
Examples:YARN,Kubernetes,Standalone cluster

Executors
Run tasks assigned by the driver
Execute transformations and actions
Store data in memory or disk
Send results back to the driver

Nodes in Spark
Master Node-Manages cluster resources,Tracks metadata
Worker/Data Nodes-Store data,Read data,Execute tasks,Write final output

**Hadoop vs Spark (Key Difference)**
Hadoop MapReduce	Spark
Disk-based processing vs	In-memory processing
Every step hits disk	Disk vs used only for final output
Slower	vs Much faster
Batch-oriented	vs Batch + Streaming

Summary
Hadoop is reliable for large-scale batch processing
Spark provides faster performance using RAM
Spark minimizes disk I/O by storing intermediate data in memory.

**Hive: SQL on Hadoop**
What it is: Hive is a data warehouse tool on top of Hadoop. It allows you to write SQL-like queries (HiveQL) to process data stored in HDFS.
Why SQL: Many analysts are comfortable with SQL, so Hive gives a familiar interface to query large datasets.
How it works: Hive converts SQL queries into MapReduce jobs or Spark jobs under the hood.
Use case: Batch processing of structured data like logs, CSV, or Parquet files.

**HBase: NoSQL on Hadoop**
What it is: HBase is a NoSQL database built on Hadoop for real-time read/write access to big data.
Why NoSQL: Some applications need very fast random access (like user profiles, counters, or time-series data) rather than scanning everything like in Hive.
How it works: HBase stores data in tables with rows and columns, but it’s column-oriented rather than row-oriented. It runs on HDFS and uses Hadoop’s scalability.
Use case: Real-time applications needing quick reads/writes on huge datasets (e.g., social media feeds, clickstream data).
