import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_hi_bank/providers/post_provider.dart';

class PostScreeen extends StatefulWidget {
  const PostScreeen({super.key});

  @override
  State<PostScreeen> createState() => _PostScreeenState();
}

class _PostScreeenState extends State<PostScreeen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<PostProvider>(context, listen: false).getPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post Data",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Provider.of<PostProvider>(context, listen: false)
                .logout(context),
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Consumer<PostProvider>(builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (v) {
                  if (v.isEmpty) {
                    Provider.of<PostProvider>(context, listen: false)
                        .getPosts();
                    return;
                  }
                  Provider.of<PostProvider>(context, listen: false)
                      .getPosts(id: v);
                },
                decoration: InputDecoration(
                  hintText: 'Search ID Post',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey[900],
                  ),
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.sort,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : state.posts.isEmpty
                        ? Center(
                            child: Text(
                              state.errorMessage ?? 'Data tidak ditemukan',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.posts.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var data = state.posts[index];
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  data.id.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'User ID ${data.userId}',
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              data.title ?? '',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            Text(
                                              data.body ?? '',
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
