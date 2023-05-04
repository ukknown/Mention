package com.ssafy.topicservice.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.elasticsearch.annotations.*;

import javax.persistence.Id;

@Document(indexName = "topic")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TopicDocument {
    @Id
    @Field(type = FieldType.Keyword)
    private Long id;

    @Field(type = FieldType.Text)
    private String title;
}